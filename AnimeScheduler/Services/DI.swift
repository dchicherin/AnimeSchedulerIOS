//
//  DI.swift
//  OTUSAPI
//
//  Created by Dmitry Chicherin on 13/7/2566 BE.
//

import Foundation
class DI {
    static let shared = DI()
    
    lazy var networkClient: NetworkClient = {
       return NetworkClient()
    }()
    
    lazy var getSchedule: GetSchedule = {
       return GetSchedule(networkClient: networkClient)
    }()
    
    lazy var getNews: GetNews = {
        return GetNews(networkClient: networkClient)
    }()
    lazy var getStatistics: GetStatistics = {
       return GetStatistics(networkClient: networkClient)
    }()
}
