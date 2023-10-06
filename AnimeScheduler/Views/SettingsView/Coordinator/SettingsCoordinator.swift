//
//  SettingsCoordinator.swift
//  Anime Scheduler
//
//  Created by Dmitry Chicherin on 7/10/2566 BE.
//

import Foundation
import UIKit

protocol SettingsModuleOuput: AnyObject {
    func moveToMySchedule()
    func moveToFullSchedule()
}

class SettingsCoordinator: Coordinator {
    var parent: Coordinator? = nil
    var child: [Coordinator] = []

    private let navController: UINavigationController

    init(controller: UINavigationController) {
        navController = controller
    }

    func start() {
        let controller = SettingsModuleBuilder.buid(output: self)
        //navController.showDetailViewController(controller, sender: self)
        //navController.show(controller, sender: self)
        navController.pushViewController(controller, animated: false)
    }
}
extension SettingsCoordinator: SettingsModuleOuput {
    func moveToMySchedule() {
        let myScheduleCoordinator = MyScheduleCoordinator(controller: navController)
        myScheduleCoordinator.start()
        print(child)
        child.append(myScheduleCoordinator)
    }
    func moveToFullSchedule() {
        let fullScheduleCoordinator = FullScheduleCoordinator(controller: navController)
        fullScheduleCoordinator.start()
        print(child)
        child.append(fullScheduleCoordinator)
    }
}
