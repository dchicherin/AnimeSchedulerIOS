//
//  FullScheduleCoordinator.swift
//  OTUSAPI
//
//  Created by Dmitry Chicherin on 25/7/2566 BE.
//

import Foundation
import UIKit

protocol FullScheduleModuleOuput: AnyObject {
    func moveToDetail(schedulePosition: SchedulePosition)
}

class FullScheduleCoordinator: Coordinator {
    var parent: Coordinator? = nil
    var child: [Coordinator] = []

    private let navController: UINavigationController

    init(controller: UINavigationController) {
        navController = controller
    }

    func start() {
        let controller = FullScheduleModuleBuilder.buid(output: self)
        //navController.showDetailViewController(controller, sender: self)
        navController.show(controller, sender: self)
    }
}
extension FullScheduleCoordinator: FullScheduleModuleOuput {
    func moveToDetail(schedulePosition: SchedulePosition) {
        let fsDetailCoordinator = FSDetailCoordinator(controller: navController)
        fsDetailCoordinator.startDetail(schedulePosition: schedulePosition)
    }
}
