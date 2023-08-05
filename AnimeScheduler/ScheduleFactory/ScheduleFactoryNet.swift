//
//  ScheduleFactoryNet.swift
//  OTUSAPI
//
//  Created by Dmitry Chicherin on 17/7/2566 BE.
//

import Foundation

struct ScheduleFactoryNet: ScheduleFactory {
    func BuidSchedule(completion: @escaping (ScheduleList) -> Void){
        var schedulePositions = [SchedulePosition]()
        DI.shared.getSchedule.getSchedule { data in
            for item in data.data {
                schedulePositions.append(item)
            }
            let finalList:ScheduleList = ScheduleList(data: schedulePositions)
            completion(finalList)
        }
    }
}
