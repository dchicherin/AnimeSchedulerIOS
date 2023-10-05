//
//  MyScheduleCoordinator.swift
//  OTUSAPI
//
//  Created by Dmitry Chicherin on 26/7/2566 BE.
//

import Foundation
import UIKit

protocol MyScheduleModuleOuput: AnyObject {
    func moveToFullSchedule()
}
class MyScheduleCoordinator: Coordinator {
    var parent: Coordinator? = nil
    var child: [Coordinator] = []

    private let navController: UINavigationController

    init(controller: UINavigationController) {
        navController = controller
    }

    func start() {
        let controller = MyScheduleModuleBuilder.buid(output: self)
        //navController.show(controller, sender: self)
        navController.pushViewController(controller, animated: false)
    }
}
extension MyScheduleCoordinator: MyScheduleModuleOuput {
    func moveToFullSchedule() {
        let myScheduleCoordinator = FullScheduleCoordinator(controller: navController)
        myScheduleCoordinator.start()
        print(child)
        child.append(myScheduleCoordinator)
    }
}
