//
//  SettingsModuleBuilder.swift
//  Anime Scheduler
//
//  Created by Dmitry Chicherin on 7/10/2566 BE.
//

import Foundation
import UIKit

final class SettingsModuleBuilder {
    static func buid(output: SettingsModuleOuput?) -> UIViewController{
        let controller: SettingsViewController = Storyboard.defaultStoryboard.buildViewController()
        controller.output = output
        Configurator.configure(viewController: controller)
        return controller
    }
}
