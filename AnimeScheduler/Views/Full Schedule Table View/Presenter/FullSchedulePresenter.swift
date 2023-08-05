//
//  FullSchedulePresenter.swift
//  OTUSAPI
//
//  Created by Dmitry Chicherin on 25/7/2566 BE.
//

import Foundation
import UIKit

protocol FullSchedulePresenterInput {
    func updateRawImage(schedulePositonForImage: SchedulePosition, image: UIImage)
    func reloadData(schedulePositions: [SchedulePosition], imagesToShow: [Int64: UIImage])
    func moveToSchedule(schedulePosition: SchedulePosition)
}

class FullSchedulePresenter: FullSchedulePresenterInput {
    
    let controller: FullScheduleTableViewControllerOutput?

    init(controller: FullScheduleTableViewControllerOutput) {
        self.controller = controller
    }
    func updateRawImage(schedulePositonForImage: SchedulePosition, image: UIImage) {
        controller?.updateRawImage(schedulePositonForImage: schedulePositonForImage, image: image)
    }
    func reloadData(schedulePositions: [SchedulePosition], imagesToShow: [Int64: UIImage]) {
        controller?.reloadScheduleData(imagesToShow: imagesToShow, schedulePositions: schedulePositions)
    }
    func moveToSchedule(schedulePosition: SchedulePosition) {
        controller?.showDetail(schedulePosition: schedulePosition)
    }
    
    
}
