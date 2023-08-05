//
//  NewsItem.swift
//  OTUSAPI
//
//  Created by Dmitry Chicherin on 16/7/2566 BE.
//

import Foundation

struct NewsItem: Codable {
    let mal_id: Int64?
    let title: String?
    let url: String?
}

struct NewsList: Codable {
    let data: [NewsItem]
}
