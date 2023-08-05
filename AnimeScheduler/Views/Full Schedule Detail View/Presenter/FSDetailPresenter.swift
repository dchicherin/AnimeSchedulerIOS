//
//  FSDetailPresenter.swift
//  OTUSAPI
//
//  Created by Dmitry Chicherin on 26/7/2566 BE.
//

import Foundation
import UIKit

protocol FSDetailPresenterInput {
    func showInitData(titleString: String, imageToShow: UIImage, synopsisString: String, addedFlag: Bool)
    func updateSavedStatus()
    func presentMessage(message: String, title: String)
}

class FSDetailPresenter: FSDetailPresenterInput {
    let controller: FSDetailViewControllerOutput?

    init(controller: FSDetailViewControllerOutput) {
        self.controller = controller
    }
    
    func showInitData(titleString: String, imageToShow: UIImage, synopsisString: String, addedFlag: Bool) {
        controller?.showInitData(titleString: titleString, imageToShow: imageToShow, synopsisString: synopsisString, addedFlag: addedFlag)
    }
    func updateSavedStatus() {
        controller?.updateSavedStatus()
    }
    func presentMessage(message: String, title: String) {
        controller?.showAlertMessage(title: title, message: message)
    }
}
