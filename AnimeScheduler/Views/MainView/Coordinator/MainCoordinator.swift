//
//  MainCoordinator.swift
//  OTUSAPI
//
//  Created by Dmitry Chicherin on 25/7/2566 BE.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var parent: Coordinator? = nil
    var child: [Coordinator] = []

    private let navController: UINavigationController

    init(controller: UINavigationController) {
        navController = controller
    }

    func start() {
        let controller = MainModuleBuider.buid(output: self)
        navController.pushViewController(controller, animated: false)
    }
}


extension MainCoordinator: MainViewModuleOutput {
    func moveToFullSchedule() {
        let fullScheduleCoordinator = FullScheduleCoordinator(controller: navController)
        fullScheduleCoordinator.start()
        child.append(fullScheduleCoordinator)
    }

    func moveToMySchedule() {
        let myScheduleCoordinator = MyScheduleCoordinator(controller: navController)
        myScheduleCoordinator.start()
        
        child.append(myScheduleCoordinator)
    }
}
