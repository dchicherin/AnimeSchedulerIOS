//
//  MainInteractor.swift
//  OTUSAPI
//
//  Created by Dmitry Chicherin on 25/7/2566 BE.
//

import Foundation
import UserNotifications

protocol MainInteractorInput {
    func pressMoveToFullSchedule()
    func pressMoveToMySchedule()
    func askNotificationPermission()
}
class MainInteractor: MainInteractorInput {

    let presenter: MainPresenterInput

    init(presenter: MainPresenter) {
        self.presenter = presenter
    }
    func pressMoveToFullSchedule() {
        presenter.presentMoveToFullSchedule()
    }
    func askNotificationPermission() {
        //Запрос на отправку уведомлений
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("All set!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func pressMoveToMySchedule() {
        presenter.presentMoveToMySchedule()
    }
    
}
