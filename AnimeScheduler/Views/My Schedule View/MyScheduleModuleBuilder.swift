//
//  MyScheduleModelBuilder.swift
//  OTUSAPI
//
//  Created by Dmitry Chicherin on 26/7/2566 BE.
//

import Foundation
import UIKit

final class MyScheduleModuleBuilder {
    static func buid(output: MyScheduleModuleOuput?) -> UIViewController{
        let controller: MyScheduleViewController = Storyboard.defaultStoryboard.buildViewController()
        controller.output = output
        Configurator.configure(viewController: controller)
        return controller
    }
}
