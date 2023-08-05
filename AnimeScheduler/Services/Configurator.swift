//
//  Configurator.swift
//  OTUSAPI
//
//  Created by Dmitry Chicherin on 25/7/2566 BE.
//

import Foundation
import UIKit

class Configurator {
    static func configure(viewController: UIViewController) {
        if let controller = viewController as? MainViewController {
            let presenter = MainPresenter(controller: controller)
            let interactor = MainInteractor(presenter: presenter)

            controller.interactor = interactor
        }else if let controller = viewController as? FullScheduleTableViewController {
            let presenter = FullSchedulePresenter(controller: controller)
            let interactor = FullScheduleInteractor(presenter: presenter)

            controller.interactor = interactor
        }else if let controller = viewController as? FSDetailViewController {
            let presenter = FSDetailPresenter(controller: controller)
            let interactor = FSDetailInteractor(presenter: presenter)
            
            controller.interactor = interactor
        }else if let controller = viewController as? MyScheduleViewController {
            let presenter = MySchedulePresenter(controller: controller)
            let interactor = MyScheduleInteractor(presenter: presenter)
            
            controller.interactor = interactor
        }
    }
}
