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
    func saveSlider(_ value: Bool)
    func getSlider() -> Bool
}
class SettingsInteractor: SettingsInteractorInput {
    func getSlider() -> Bool {
        return UserDefaults.standard.bool(forKey: "ShowOlder")
    }
    

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
    func saveSlider(_ value: Bool){
        UserDefaults.standard.set(value, forKey: "ShowOlder")
    }
}
