//
//  FullScheduleModuleBuilder.swift
//  OTUSAPI
//
//  Created by Dmitry Chicherin on 26/7/2566 BE.
//

import Foundation
import UIKit

final class FullScheduleModuleBuilder {
    static func buid(output: FullScheduleModuleOuput?) -> UIViewController{
        let controller: FullScheduleTableViewController = Storyboard.defaultStoryboard.buildViewController()
        controller.output = output
        Configurator.configure(viewController: controller)
        return controller
    }
}
