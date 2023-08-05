//
//  StatisticsItem.swift
//  OTUSAPI
//
//  Created by Dmitry Chicherin on 16/7/2566 BE.
//

import Foundation

struct StatisticsItem: Codable {
    let watching: Int64?
    let dropped: Int64?
}

struct Statistics: Codable {
    let data: StatisticsItem
}
