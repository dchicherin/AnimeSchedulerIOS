//
//  FSDetailCoordinator.swift
//  OTUSAPI
//
//  Created by Dmitry Chicherin on 26/7/2566 BE.
//

import Foundation
import UIKit


class FSDetailCoordinator: Coordinator {
    
    var parent: Coordinator? = nil
    var child: [Coordinator] = []

    private let navController: UINavigationController

    init(controller: UINavigationController) {
        navController = controller
    }

    func start() {
        let controller = FSDetailModuleBuider.buid(output: self)
        navController.showDetailViewController(controller, sender: self)
    }
    func startDetail(schedulePosition: SchedulePosition){
        let controller = FSDetailModuleBuider.buidWithInfo(output: self, schedulePosition: schedulePosition)
        navController.showDetailViewController(controller, sender: self)
    }
}
