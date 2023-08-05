//
//  FullScheduleTableViewController.swift
//  OTUSAPI
//
//  Created by Dmitry Chicherin on 12/7/2566 BE.
//

import UIKit


protocol FullScheduleTableViewControllerOutput {
    func updateRawImage(schedulePositonForImage: SchedulePosition, image: UIImage)
    func reloadScheduleData(imagesToShow: [Int64: UIImage], schedulePositions: [SchedulePosition])
    func showDetail(schedulePosition: SchedulePosition)
}

class FullScheduleTableViewController: UITableViewController{
    
    var schedulePositions = [SchedulePosition]()
    var imagesDict: [Int64: UIImage] = [:]
    var rowsDictionary: [Int64: Int] = [:]
    var interactor: FullScheduleInteractorInput?
    weak var output: FullScheduleModuleOuput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100.0
        self.tableView.delegate = self
        self.tableView.dataSource = self
        //Configurator.configure(viewController: self)
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
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "ScheduleViewCell")
        if let tableCell = tableCell as? ScheduleViewCell {
            let cellInfo = schedulePositions[indexPath.row]
            tableCell.setup(withScheduleItem: cellInfo, imageToShow: imagesDict[cellInfo.mal_id])
            rowsDictionary[cellInfo.mal_id] = indexPath.row
        }
        return tableCell!
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor?.moveToSchedule(schedulePosition: schedulePositions[indexPath.row])
    }
}

extension FullScheduleTableViewController: FullScheduleTableViewControllerOutput {
    func showDetail(schedulePosition: SchedulePosition) {
        output?.moveToDetail(schedulePosition: schedulePosition)
    }
    
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
}
