//
//  SettingsViewController.swift
//  Anime Scheduler
//
//  Created by Dmitry Chicherin on 6/10/2566 BE.
//

import UIKit

protocol SettingsViewControllerInput {
    func showFullSchedule()
    func showMySchedule()
}


class SettingsViewController: UIViewController {
    
    weak var output: SettingsModuleOuput?
    var interactor: SettingsInteractorInput?
    
    //Additional elements
    private let bottomNavBar: UIView = {
        //View to show on screen when no tasks are present
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.6549019608, green: 0.5098039216, blue: 0.9254901961, alpha: 1)
        return view
    }()
    private let buttonFS: UIButton = {
        //Creating a floating button
        let buttonFS = UIButton(frame: CGRect(x: 40, y: 5, width: 60, height: 60))
        buttonFS.layer.masksToBounds = true
        let image = UIImage(systemName: "list.bullet.rectangle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .medium))
        buttonFS.setImage(image, for: .normal)
        buttonFS.tintColor = .white
        buttonFS.addTarget(self, action: #selector(moveToFullSchedule), for: .touchUpInside)
        return buttonFS
    }()
    private let buttonMS: UIButton = {
        //Creating a floating button
        let buttonFS = UIButton(frame: CGRect(x: 40, y: 5, width: 60, height: 60))
        buttonFS.layer.masksToBounds = true
        let image = UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .medium))
        buttonFS.setImage(image, for: .normal)
        buttonFS.tintColor = .white
        buttonFS.addTarget(self, action: #selector(moveToMySchedule), for: .touchUpInside)
        return buttonFS
    }()
    private let buttonSettings: UIButton = {
        //Creating a floating button
        let buttonFS = UIButton(frame: CGRect(x: 40, y: 5, width: 60, height: 60))
        buttonFS.layer.masksToBounds = true
        let image = UIImage(systemName: "gear", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .medium))
        buttonFS.setImage(image, for: .normal)
        buttonFS.tintColor = .white
        return buttonFS
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bottomNavBar.frame = CGRect(x: 0, y: view.frame.size.height - 85, width: view.frame.size.width, height: 85)
        
        bottomNavBar.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(bottomNavBar)
        bottomNavBar.addSubview(buttonFS)
        bottomNavBar.addSubview(buttonMS)
        bottomNavBar.addSubview(buttonSettings)
        buttonMS.frame =  CGRect(x: view.frame.size.width/2 - 30, y: 5, width: 60, height: 60)
        buttonSettings.frame = CGRect(x: view.frame.size.width - 100, y: 5, width: 60, height: 60)
    }
    @objc func moveToMySchedule(sender: UIButton!) {
        output?.moveToMySchedule()
    }
    @objc func moveToFullSchedule(sender: UIButton!) {
        output?.moveToFullSchedule()
    }
}
extension SettingsViewController: SettingsViewControllerInput {
    func showFullSchedule() {
        //output?.moveToFullSchedule()
    }
    
    func showMySchedule() {
        output?.moveToMySchedule()
    }
    
    
}
