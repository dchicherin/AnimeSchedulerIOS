//
//  FullScheduleIterator.swift
//  OTUSAPI
//
//  Created by Dmitry Chicherin on 25/7/2566 BE.
//

import Foundation
import UIKit

protocol FullScheduleInteractorInput {
    func getScheduleData()
    func moveToSchedule(schedulePosition: SchedulePosition)
}

class FullScheduleInteractor: FullScheduleInteractorInput {

    
    let presenter: FullSchedulePresenterInput?
    var schedulePositions = [SchedulePosition]()
    var imagesDict: [Int64: UIImage] = [:]
    var rowsDictionary: [Int64: Int] = [:]

    init(presenter: FullSchedulePresenter) {
        self.presenter = presenter
    }
    func getScheduleData() {
        let scheduleFactory:ScheduleFactory = ScheduleFactoryNet()
        scheduleFactory.BuidSchedule { data in
            for item in data.data {
                if !self.schedulePositions.contains(where: {$0.mal_id == item.mal_id}){
                    self.schedulePositions.append(item)
                }
            }
            self.schedulePositions.sort(by: {$0.members ?? 0 > $1.members ?? 0})
            
            //Получение картинок из кеша и при неудаче асинхронная подгрузка
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
                    //Обновляем только нужную строчку
                    self.presenter?.updateRawImage(schedulePositonForImage: schedulePositonForImage, image: imageUI)

                }
            }
            queueAsync.addOperation(downloadOperation)
        }
    }
    func moveToSchedule(schedulePosition: SchedulePosition) {
        presenter?.moveToSchedule(schedulePosition: schedulePosition)
    }
}
