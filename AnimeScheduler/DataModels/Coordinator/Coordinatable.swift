//
//  Coordinatable.swift
//  OTUSAPI
//
//  Created by Dmitry Chicherin on 25/7/2566 BE.
//

import Foundation

protocol Coordinatable: AnyObject {
    var coordinator: Coordinator? { get set }
}
