//
//  ScheduleFactory.swift
//  OTUSAPI
//
//  Created by Dmitry Chicherin on 17/7/2566 BE.
//


//Фабрика для создания объектов с расписанием. Build ничего не возвращает, но позволяет обращаться к результату
import Foundation

protocol ScheduleFactory {
    func BuidSchedule(completion: @escaping(ScheduleList)->Void)
}
