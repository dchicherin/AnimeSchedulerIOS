//
//  Coordinator.swift
//  OTUSAPI
//
//  Created by Dmitry Chicherin on 25/7/2566 BE.
//

import Foundation

protocol Coordinator {
    var parent: Coordinator? { get set }
    var child: [Coordinator] { get set }

    func start()
}
