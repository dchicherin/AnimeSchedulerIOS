//
//  MainViewBuilder.swift
//  OTUSAPI
//
//  Created by Dmitry Chicherin on 26/7/2566 BE.
//

import Foundation
import UIKit

final class MainModuleBuider {
    static func buid(output: MainViewModuleOutput?) -> UIViewController{
        let controller: MainViewController = Storyboard.defaultStoryboard.buildViewController()
        controller.output = output
        Configurator.configure(viewController: controller)
        return controller
    }
}
