//
//  ImageCache.swift
//  OTUSAPI
//
//  Created by Dmitry Chicherin on 16/7/2566 BE.
//

import Foundation

class ImageCache {
    static let shared = ImageCache()
    var imageCache = NSCache<NSString, NSData>()
    private init() {}
}
