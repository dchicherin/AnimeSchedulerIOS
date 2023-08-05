//
//  Storyboard.swift
//  OTUSAPI
//
//  Created by Dmitry Chicherin on 25/7/2566 BE.
//

import Foundation
import UIKit


enum Storyboard: String {
    case main = "Main"

    static var defaultStoryboard: UIStoryboard {
        return UIStoryboard(name: Storyboard.main.rawValue, bundle: nil)
    }
}

extension UIStoryboard {
    func buildViewController<T>(controllerName: String = String(describing: T.self)) -> T {
        return instantiateViewController(withIdentifier: controllerName) as! T
    }
}
