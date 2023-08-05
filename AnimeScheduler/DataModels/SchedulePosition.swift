//
//  SchedulePosition.swift
//  OTUSAPI
//
//  Created by Dmitry Chicherin on 13/7/2566 BE.
//

import Foundation
//Описание структуры в соответствии с JSON'ом

struct SchedulePosition: Codable {
    let mal_id: Int64
    let title: String
    let broadcast: ScheduleTiming?
    let images: Images?
    let synopsis: String?
    let members: Int64?
    
    enum CodingKeys: String, CodingKey{
        case images = "images"
        case mal_id = "mal_id"
        case title = "title"
        case broadcast = "broadcast"
        case synopsis = "synopsis"
        case members
    }
}
struct Images: Codable{
    let jpg: JPG?
}
struct JPG: Codable{
    let image_url: String?
}

struct ScheduleTiming: Codable {
    let day: String?
    let time: String?
}
struct ScheduleList: Codable {
    let data: [SchedulePosition]
}



