//
//  MyScheduleInteractor.swift
//  OTUSAPI
//
//  Created by Dmitry Chicherin on 26/7/2566 BE.
//

import Foundation
import UIKit
import CoreData

protocol MyScheduleInteractorInput {
    func getScheduleData()
    func deleteRecord(fetchRequest: NSFetchRequest<ScheduleStored>, malId: Int64, rowNum: Int)
}

class MyScheduleInteractor: MyScheduleInteractorInput {
    let presenter: MySchedulePresenterInput?
    var schedulePositions = [SchedulePosition]()
    var imagesDict: [Int64: UIImage] = [:]
    var rowsDictionary: [Int64: Int] = [:]
    private let coreDataService = CoreDataService()

    init(presenter: MySchedulePresenterInput) {
        self.presenter = presenter
    }
    
    func getScheduleData() {
        let scheduleFactory:ScheduleFactory = ScheduleFactoryDB()
        //После получения данных отображаем их так же - и с подгрузкой картинок
        scheduleFactory.BuidSchedule { data in
            for item in data.data {
                    self.schedulePositions.append(item)
  
            }
            //получение картинок из кеша. если не удается, то отправляем запрос
            var imagesToLoad = [SchedulePosition]()
            for scheduleToCheck in self.schedulePositions{
                if let cashedVersion = ImageCache.shared.imageCache.object(forKey: String(scheduleToCheck.mal_id) as NSString) {
                    self.imagesDict[scheduleToCheck.mal_id] = UIImage(data: cashedVersion as Data)
                    print("image loaded from cache")
                }else {
                    imagesToLoad.append(scheduleToCheck)
                }
            }
            self.downloadImages(imagesToLoad: imagesToLoad)
            self.presenter?.reloadData(schedulePositions: self.schedulePositions, imagesToShow: self.imagesDict)
        }
    }
    func downloadImages(imagesToLoad: [SchedulePosition]){
        let queueAsync = OperationQueue()
        for schedulePositonForImage in imagesToLoad{
            let downloadOperation = DownloadOperation(url: schedulePositonForImage.images?.jpg?.image_url ?? "https://upload.wikimedia.org/wikipedia/commons/6/65/No-Image-Placeholder.svg")
            downloadOperation.completionBlock = {
                DispatchQueue.main.async {
                     guard let imageUI = UIImage(data: downloadOperation.outputImage!)
                    else {
                        return
                    }
                    //let imageData = ImageWrapper(image: imageUI, urlText: image.images?.jpg?.image_url)
                    self.imagesDict[schedulePositonForImage.mal_id] = imageUI
                    ImageCache.shared.imageCache.setObject(downloadOperation.outputImage! as NSData, forKey: String(schedulePositonForImage.mal_id) as NSString)
                    //self.images.append(imageData)
                    self.presenter?.updateRawImage(schedulePositonForImage: schedulePositonForImage, image: imageUI)
                }
            }
            queueAsync.addOperation(downloadOperation)
        }
    }
    func deleteRecord(fetchRequest: NSFetchRequest<ScheduleStored>, malId: Int64, rowNum: Int) {
        //Удаление записи из базы
        fetchRequest.predicate = NSPredicate(
            format: "mal_id = %@", String(malId)
        )
        let context = self.coreDataService.context()
        let objectToDeleteDB = try? context.fetch(fetchRequest)
        if objectToDeleteDB?[0] != nil {
            context.delete(objectToDeleteDB![0])
        }

        try? context.save()
        //Удаление уведомлений
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [String(malId)])
        presenter?.removeRow(at: rowNum)
    }
}
