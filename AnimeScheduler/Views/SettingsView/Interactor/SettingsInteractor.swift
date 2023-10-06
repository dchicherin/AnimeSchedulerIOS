//
//  SettingsInteractor.swift
//  Anime Scheduler
//
//  Created by Dmitry Chicherin on 7/10/2566 BE.
//

import Foundation
import UserNotifications

protocol SettingsInteractorInput {
    func pressMoveToFullSchedule()
    func pressMoveToMySchedule()
}
class SettingsInteractor: SettingsInteractorInput {

    let presenter: SettingsPresenterInput

    init(presenter: SettingsPresenter) {
        self.presenter = presenter
    }
    func pressMoveToFullSchedule() {
        presenter.presentMoveToFullSchedule()
    }
    
    func pressMoveToMySchedule() {
        presenter.presentMoveToMySchedule()
    }
    
}
