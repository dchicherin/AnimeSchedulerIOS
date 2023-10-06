//
//  SettingsPresenter.swift
//  Anime Scheduler
//
//  Created by Dmitry Chicherin on 7/10/2566 BE.
//

import Foundation

protocol SettingsPresenterInput {
    func presentMoveToFullSchedule()
    func presentMoveToMySchedule()
}

class SettingsPresenter: SettingsPresenterInput {

    let controller: SettingsViewControllerInput

    init(controller: SettingsViewControllerInput) {
        self.controller = controller
    }
    
    func presentMoveToFullSchedule() {
        controller.showFullSchedule()
    }
    
    func presentMoveToMySchedule() {
        controller.showMySchedule()
    }
}
