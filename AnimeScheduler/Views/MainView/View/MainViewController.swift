//
//  ViewController.swift
//  OTUSAPI
//
//  Created by Dmitry Chicherin on 12/7/2566 BE.
//

import UIKit
import UserNotifications

protocol MainViewControllerInput {
    func showFullSchedule()
    func showMySchedule()
}

class MainViewController: UIViewController{
    
    @IBOutlet weak var myScheduleButton: UIButton!
    @IBOutlet weak var fullScheduleButton: UIButton!
    var interactor: MainInteractorInput?
    weak var output: MainViewModuleOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.askNotificationPermission()
        //Тень в текст кнопок
        //addButtonShadow(buttonToMod: myScheduleButton)
        //addButtonShadow(buttonToMod: fullScheduleButton)
    }
    @IBAction func goToFullScheduleTapped(_ sender: Any) {
        //output?.moveToFullSchedule()
        interactor?.pressMoveToFullSchedule()
    }
    @IBAction func goToMyScheduleTapped(_ sender: Any) {
        interactor?.pressMoveToMySchedule()
    }
    func addButtonShadow(buttonToMod: UIButton){
        buttonToMod.titleLabel?.layer.shadowColor = UIColor.black.cgColor
        buttonToMod.titleLabel!.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        buttonToMod.titleLabel!.layer.shadowOpacity = 1.0
        buttonToMod.titleLabel!.layer.shadowRadius = 0
        buttonToMod.titleLabel!.layer.masksToBounds = false
    }
}

extension MainViewController: MainViewControllerInput {
    func showFullSchedule() {
        output?.moveToFullSchedule()
    }
    
    func showMySchedule() {
        output?.moveToMySchedule()
    }
    
    
}
