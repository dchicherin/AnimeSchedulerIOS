//
//  MyScheduleViewController.swift
//  OTUSAPI
//
//  Created by Dmitry Chicherin on 17/7/2566 BE.
//

import UIKit
import CoreData
import FirebaseAnalytics

protocol MyScheduleViewControllerOutput {
    func updateRawImage(schedulePositonForImage: SchedulePosition, image: UIImage)
    func reloadScheduleData(imagesToShow: [Int64: UIImage], schedulePositions: [SchedulePosition])
    func removeRow(at: Int)
}

class MyScheduleViewController: UITableViewController{
    
    var schedulePositions = [SchedulePosition]()
    var imagesDict: [Int64: UIImage] = [:]
    var rowsDictionary: [Int64: Int] = [:]
    var interactor: MyScheduleInteractorInput?
    weak var output: MyScheduleModuleOuput?
    
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
        tableView.rowHeight = 100.0
        interactor?.getScheduleData()
        bottomNavBar.frame = CGRect(x: 0, y: view.frame.size.height - 120, width: view.frame.size.width, height: 80)
        
        bottomNavBar.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(bottomNavBar)
        bottomNavBar.addSubview(buttonFS)
        bottomNavBar.addSubview(buttonMS)
        bottomNavBar.addSubview(buttonSettings)
        buttonMS.frame =  CGRect(x: view.frame.size.width/2 - 30, y: 5, width: 60, height: 60)
        buttonSettings.frame = CGRect(x: view.frame.size.width - 100, y: 5, width: 60, height: 60)
        //removing nav bar
        self.navigationController?.isNavigationBarHidden = true
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //Making scroll button stay in place
        let offset = scrollView.contentOffset.y
        bottomNavBar.frame = CGRect(x: 0, y: view.frame.size.height - 85 + offset, width: view.frame.size.width, height: 85)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return schedulePositions.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Передача инфы в строки
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "ScheduleViewCell")
        if let tableCell = tableCell as? ScheduleViewCell {
            let cellInfo = schedulePositions[indexPath.row]
            tableCell.setup(withScheduleItem: cellInfo, imageToShow: imagesDict[cellInfo.mal_id])
            rowsDictionary[cellInfo.mal_id] = indexPath.row
        }
        return tableCell!
    }
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        //Удаление из списка по свайпу
        let delete = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, handler in
            guard let self else {
                return
            }

            let positionToDelete = self.schedulePositions[indexPath.row].mal_id
            let fetchRequest: NSFetchRequest<ScheduleStored>
            fetchRequest = ScheduleStored.fetchRequest()
            interactor?.deleteRecord(fetchRequest: fetchRequest, malId: positionToDelete, rowNum: indexPath.row)
            
            handler(true)
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }
    @objc func moveToFullSchedule(sender: UIButton!) {
        output?.moveToFullSchedule()
    }
}

extension MyScheduleViewController: MyScheduleViewControllerOutput {
    func updateRawImage(schedulePositonForImage: SchedulePosition, image: UIImage) {
        self.imagesDict[schedulePositonForImage.mal_id] = image
        self.tableView.beginUpdates()
        let rowToUpdate = self.rowsDictionary[schedulePositonForImage.mal_id] ?? 0
        let indexPosition = IndexPath(row: rowToUpdate, section: 0)
        self.tableView.reloadRows(at: [indexPosition], with: UITableView.RowAnimation.none)
        self.tableView.endUpdates()
    }
    func reloadScheduleData(imagesToShow: [Int64: UIImage], schedulePositions: [SchedulePosition]){
        self.imagesDict = imagesToShow
        self.schedulePositions = schedulePositions
        self.tableView.reloadData()
    }
    func removeRow(at: Int) {
        self.schedulePositions.remove(at: at)
        self.tableView.reloadData()
    }
}
