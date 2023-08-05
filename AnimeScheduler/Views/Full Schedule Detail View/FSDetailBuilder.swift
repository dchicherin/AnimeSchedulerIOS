//
//  FSDetailBuilder.swift
//  OTUSAPI
//
//  Created by Dmitry Chicherin on 26/7/2566 BE.
//

import Foundation
import UIKit

final class FSDetailModuleBuider {
    static func buid(output: AnyObject?) -> UIViewController{
        let controller: FSDetailViewController = Storyboard.defaultStoryboard.buildViewController()
        //controller.output = output
        Configurator.configure(viewController: controller)
        return controller
    }
    static func buidWithInfo(output: AnyObject?, schedulePosition: SchedulePosition) -> FSDetailViewController{
        let controller: FSDetailViewController = Storyboard.defaultStoryboard.buildViewController()
        
        Configurator.configure(viewController: controller)
        controller.selectedPosition = schedulePosition
        return controller
    }
}
