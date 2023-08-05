//
//  MySchedulePresenter.swift
//  OTUSAPI
//
//  Created by Dmitry Chicherin on 26/7/2566 BE.
//

import Foundation
import UIKit

protocol MySchedulePresenterInput {
    func updateRawImage(schedulePositonForImage: SchedulePosition, image: UIImage)
    func reloadData(schedulePositions: [SchedulePosition], imagesToShow: [Int64: UIImage])
    func removeRow(at: Int)
}
class MySchedulePresenter: MySchedulePresenterInput {
    let controller: MyScheduleViewControllerOutput?

    init(controller: MyScheduleViewControllerOutput) {
        self.controller = controller
    }
    func updateRawImage(schedulePositonForImage: SchedulePosition, image: UIImage) {
        controller?.updateRawImage(schedulePositonForImage: schedulePositonForImage, image: image)
    }
    func reloadData(schedulePositions: [SchedulePosition], imagesToShow: [Int64: UIImage]) {
        controller?.reloadScheduleData(imagesToShow: imagesToShow, schedulePositions: schedulePositions)
    }
    func removeRow(at: Int) {
        controller?.removeRow(at: at)
    }
}
