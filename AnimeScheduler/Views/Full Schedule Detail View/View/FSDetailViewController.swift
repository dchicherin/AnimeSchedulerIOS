//
//  FSDetailViewController.swift
//  OTUSAPI
//
//  Created by Dmitry Chicherin on 16/7/2566 BE.
//

import UIKit
import CoreData
import FirebaseAnalytics

protocol FSDetailViewControllerOutput {
    func showInitData(titleString: String, imageToShow: UIImage, synopsisString: String, addedFlag: Bool)
    func updateSavedStatus()
    func showAlertMessage(title: String, message: String)
}


class FSDetailViewController: UIViewController {
    
    var selectedPosition: SchedulePosition? = nil
    
    @IBOutlet weak var viewMALButton: UIButton!
    @IBOutlet weak var imageBigView: UIImageView!
    @IBOutlet weak var synopsisTextView: UITextView!
    @IBOutlet weak var addToWatchButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var showNewsButton: UIButton!
    @IBOutlet weak var addedLabel: UILabel!
    @IBOutlet weak var getStatisticsButton: UIButton!
    var interactor: FSDetailInteractorInput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(selectedPosition != nil){
            interactor?.checkData(schedulePosition: selectedPosition!)
        }
    }
    @IBAction func OpenMALTouchUpInside(_ sender: Any) {
        //Переход на сайт с подробной информацией
        interactor?.openMALPage(malId: selectedPosition!.mal_id)
    }
    func addButtonShadow(buttonToMod: UIButton){
        buttonToMod.titleLabel?.layer.shadowColor = UIColor.black.cgColor
        buttonToMod.titleLabel!.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        buttonToMod.titleLabel!.layer.shadowOpacity = 1.0
        buttonToMod.titleLabel!.layer.shadowRadius = 0
        buttonToMod.titleLabel!.layer.masksToBounds = false
    }
    @IBAction func newsButtonTouchUpInside(_ sender: Any) {
        //Запрос для получения новостей  Отображает их в алерте
        if selectedPosition != nil {
            interactor?.getNews(malId: selectedPosition!.mal_id)
        }
    }
    
    @IBAction func AddToWatchButtonTouchUpInside(_ sender: Any) {
        //Добавление в базу сохраненныe шоу
        if (selectedPosition != nil){
            interactor?.savePosition(positionToSave: selectedPosition!)
        }
    }
    @IBAction func getStatisticsButtonTouchUpInside(_ sender: Any) {
        //Получение статистики и отображение ее в алерте
        if selectedPosition != nil {
            interactor?.getStats(malId: selectedPosition!.mal_id)
        }
    }
}
extension FSDetailViewController: FSDetailViewControllerOutput {
    func showAlertMessage(title: String, message: String) {
        let dialogMessage = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            //print("Ok button tapped")
         })
        
        dialogMessage.addAction(ok)
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    func updateSavedStatus() {
        addToWatchButton.isHidden = true
        addedLabel.text = "Already added!"
    }
    
    func showInitData(titleString: String, imageToShow: UIImage, synopsisString: String, addedFlag: Bool) {
        if addedFlag == false {
            addedLabel.text = ""
        } else {
            addToWatchButton.isHidden = true
            addedLabel.text = "Already added!"
        }
        imageBigView.image = imageToShow
        synopsisTextView.text = synopsisString
        titleLabel.text = titleString
    }
    
}
