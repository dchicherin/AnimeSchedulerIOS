//
//  Requests.swift
//  OTUSAPI
//
//  Created by Dmitry Chicherin on 13/7/2566 BE.
//

import Foundation
enum Requests {
    //АPI не предоставляет возможности получить всё расписание за раз, поэтому запросов несколько
    case schedule
    case schedule2
    case schedule3
    case schedule4
    case schedule5
    case newsList(query: String)
    case statistics(query: String)
    
    var path: String {
        switch self {
        case .schedule:
            return "/v4/schedules/"
        case .schedule2:
            return "/v4/schedules/?page=2"
        case .schedule3:
            return "/v4/schedules/?page=3"
        case .schedule4:
            return "/v4/schedules/?page=4"
        case .schedule5:
            return "/v4/schedules/?page=5"
        case .newsList(let query):
            return "/v4/anime/\(query)/news"
        case .statistics(let query):
            return "/v4/anime/\(query)/statistics"
        }
    }
}
