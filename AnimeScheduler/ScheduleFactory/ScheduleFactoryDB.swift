//
//  ScheduleFactoryDB.swift
//  OTUSAPI
//
//  Created by Dmitry Chicherin on 17/7/2566 BE.
//

import Foundation
import CoreData

struct ScheduleFactoryDB: ScheduleFactory {
    final class CoreDataService {

        private let container: NSPersistentContainer = {
            let container = NSPersistentContainer(name: "Model")
            container.loadPersistentStores { _, error in
                if let error = error {
                    fatalError(error.localizedDescription)
                }
            }
            return container
        }()

        func context() -> NSManagedObjectContext {
            return container.viewContext
        }

    }
    func BuidSchedule(completion: @escaping (ScheduleList) -> Void) {
        var schedulePositions = [SchedulePosition]()
        let request = NSFetchRequest<ScheduleStored>(entityName: "ScheduleStored")
        request.returnsObjectsAsFaults = false
        let scheduleDB = try? CoreDataService().context().fetch(request)
        let scheduleDBF = scheduleDB ?? []
        for item in scheduleDBF{
            schedulePositions.append(SchedulePosition(mal_id: item.mal_id, title: item.title!, broadcast: ScheduleTiming(day: item.day, time: item.time), images: Images(jpg: JPG(image_url: item.image_url)), synopsis: item.synopsis,  members: 0))
        }
        let finalList:ScheduleList = ScheduleList(data: schedulePositions)
        completion(finalList)
    }
    

}
