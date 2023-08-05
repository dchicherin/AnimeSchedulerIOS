//
//  MyScheduleModelBuilder.swift
//  OTUSAPI
//
//  Created by Dmitry Chicherin on 26/7/2566 BE.
//

import Foundation
import UIKit

final class MyScheduleModuleBuilder {
    static func buid() -> UIViewController{
        let controller: MyScheduleViewController = Storyboard.defaultStoryboard.buildViewController()
        Configurator.configure(viewController: controller)
        return controller
    }
}
