//
//  MainPresenter.swift
//  OTUSAPI
//
//  Created by Dmitry Chicherin on 25/7/2566 BE.
//

import Foundation

protocol MainPresenterInput {
    func presentMoveToFullSchedule()
    func presentMoveToMySchedule()
}

class MainPresenter: MainPresenterInput {

    let controller: MainViewControllerInput

    init(controller: MainViewControllerInput) {
        self.controller = controller
    }
    
    func presentMoveToFullSchedule() {
        controller.showFullSchedule()
    }
    
    func presentMoveToMySchedule() {
        controller.showMySchedule()
    }
}
