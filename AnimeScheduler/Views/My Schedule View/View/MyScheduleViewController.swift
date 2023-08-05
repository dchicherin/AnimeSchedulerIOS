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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100.0
        interactor?.getScheduleData()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
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
