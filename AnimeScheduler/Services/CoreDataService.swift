//
//  CoreDataService.swift
//  OTUSAPI
//
//  Created by Dmitry Chicherin on 17/7/2566 BE.
//

import Foundation
import CoreData

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
