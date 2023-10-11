//
//  FSDetailIterator.swift
//  OTUSAPI
//
//  Created by Dmitry Chicherin on 26/7/2566 BE.
//

import Foundation
import UIKit
import CoreData
import FirebaseAnalytics

protocol FSDetailInteractorInput {
    func checkData(schedulePosition: SchedulePosition)
    func openMALPage(malId: Int64)
    func savePosition(positionToSave: SchedulePosition)
    func getNews(malId: Int64)
    func getStats(malId: Int64)
}
class FSDetailInteractor: FSDetailInteractorInput {
    
    
    let presenter: FSDetailPresenterInput?
    private let coreDataService = CoreDataService()

    init(presenter: FSDetailPresenterInput) {
        self.presenter = presenter
    }
    
    func savePosition(positionToSave: SchedulePosition) {
        //Сохранение выбранной позиции в базу
        let context = self.coreDataService.context()
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        let newSchedule = ScheduleStored(context: context)
        newSchedule.mal_id = positionToSave.mal_id
        newSchedule.image_url = positionToSave.images?.jpg?.image_url
        newSchedule.title = positionToSave.title
        newSchedule.synopsis = positionToSave.synopsis
        newSchedule.time = positionToSave.broadcast?.time
        newSchedule.day = positionToSave.broadcast?.day
        do {
            try context.save()
            /*
            //Установка уведомления о начале
            let content = UNMutableNotificationContent()
            content.title = "\(positionToSave.title) aires today"
            content.subtitle = "A new episode of a show you are watching is airing"
            content.sound = UNNotificationSound.default
            var notificationNeeded = true
            var notificationDate = Date()
            switch positionToSave.broadcast?.day {
            case "Mondays":
                notificationDate = Date().get(direction: .next, dayName: .Mondays)
            case "Tuesdays":
                notificationDate = Date().get(direction: .next, dayName: .Tuesdays)
            case "Wednesdays":
                notificationDate = Date().get(direction: .next, dayName: .Wednesdays)
            case "Thursdays":
                notificationDate = Date().get(direction: .next, dayName: .Thursdays)
            case "Fridays":
                notificationDate = Date().get(direction: .next, dayName: .Fridays)
            case "Saturdays":
                notificationDate = Date().get(direction: .next, dayName: .Saturdays)
            case "Sundays":
                notificationDate = Date().get(direction: .next, dayName: .Sundays)
            default:
                notificationDate = Date()
                notificationNeeded = false
            }
            if notificationNeeded {
                notificationDate = notificationDate.setTime(hour: 18, min: 0, sec: 0)!
                //Для дебага время - 20 секунд
                var secondsCountDown = floor(notificationDate.timeIntervalSinceNow)
                secondsCountDown = 90
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: secondsCountDown, repeats: false)
                
                let request = UNNotificationRequest(identifier: String(positionToSave.mal_id), content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request)
            }*/
            presenter?.updateSavedStatus()
        } catch {
            print(error)
        }
    }
    
    func openMALPage(malId: Int64) {
        //Простое открытие страницы в раузере
        let malString = String(malId)
        if let url = URL(string: "https://myanimelist.net/anime/\(malString)"){
            UIApplication.shared.open(url)
        }
    }
    
    func checkData(schedulePosition: SchedulePosition) {
        //Получение простых стрингов
        let titleString = schedulePosition.title
        let synopsis = schedulePosition.synopsis ?? ""
        //Реквест в базу для проверки, добавлено ли шоу в список для просмотра
        let fetchRequest: NSFetchRequest<ScheduleStored>
        fetchRequest = ScheduleStored.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(
            format: "mal_id = %@", String(schedulePosition.mal_id)
        )
        let context = self.coreDataService.context()
        let objectToCheck = try? context.fetch(fetchRequest)
        var addedFlag:Bool
        if objectToCheck?.count == 0 {
            addedFlag = false
            
        } else {
            addedFlag = true
        }
        //Отрисовка - сначала пробуем из кеша и потом пробуем загрузить
        var imageToShow: UIImage
        if let imageData = ImageCache.shared.imageCache.object(forKey: String(schedulePosition.mal_id) as NSString) {
            imageToShow = UIImage(data: imageData as Data)!
            self.presenter?.showInitData(titleString: titleString, imageToShow: imageToShow, synopsisString: synopsis, addedFlag: addedFlag)
            
        } else {
            let queueAsync = OperationQueue()
            let downloadOperation = DownloadOperation(url: schedulePosition.images?.jpg?.image_url ?? "https://upload.wikimedia.org/wikipedia/commons/6/65/No-Image-Placeholder.svg")
            downloadOperation.completionBlock = {
                DispatchQueue.main.async {
                    guard let imageUI = UIImage(data: downloadOperation.outputImage!)
                    else {
                        return
                    }
                    self.presenter?.showInitData(titleString: titleString, imageToShow: imageUI, synopsisString: synopsis, addedFlag: addedFlag)
                    
                }
            }
            queueAsync.addOperation(downloadOperation)
        }
        
    }
    
    func getNews(malId: Int64) {
        var newsList: String = ""
        let malString = String(malId)
        DI.shared.getNews.getNews(query: malString){
            data in
            for item in data.data {
                newsList = newsList + "\n\n\(item.title!)"
                //print(item)
            }
            self.presenter?.presentMessage(message: newsList, title: "Recent News")
        }
    }
    func getStats(malId: Int64) {
        let malString = String(malId)
        DI.shared.getStatistics.getStatistics(query: malString){
            data in
            let statMessage = "Watching: \(data.data.watching!) dropped: \(data.data.dropped!)"
            
            self.presenter?.presentMessage(message: statMessage, title: "Statistics")        }
    }
}
