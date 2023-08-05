//
//  AppCoordinator.swift
//  OTUSAPI
//
//  Created by Dmitry Chicherin on 25/7/2566 BE.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    var parent: Coordinator? = nil
    var child: [Coordinator] = []
    var uiWindow: UIWindow? = nil

    private let navController: UINavigationController

    init(controller: UINavigationController = UINavigationController()) {
        navController = controller
    }

    func initScene(baseScene: UIWindowScene) {
        uiWindow = UIWindow(windowScene: baseScene)
    }

    func start() {
        let startup = MainCoordinator(controller: navController)
        startup.start()

        uiWindow?.rootViewController = navController
        uiWindow?.makeKeyAndVisible()

        child.append(startup)
    }
}
