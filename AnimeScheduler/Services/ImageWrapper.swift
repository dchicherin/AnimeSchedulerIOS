//
//  ImageWrapper.swift
//  OTUSAPI
//
//  Created by Dmitry Chicherin on 16/7/2566 BE.
//

import Foundation
import UIKit

class ImageWrapper {
    var image: UIImage? = nil
    var urlText: String? = nil
    
    init(image: UIImage? = nil, urlText: String? = nil) {
        self.image = image
        self.urlText = urlText
    }
}
