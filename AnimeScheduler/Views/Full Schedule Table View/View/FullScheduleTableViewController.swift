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
        let image = UIImage(systemName: "list.bullet.rectangle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .bold))
        buttonFS.setImage(image, for: .normal)
        buttonFS.tintColor = .white
        return buttonFS
    }()
    private let buttonMS: UIButton = {
        //Creating a floating button
        let buttonFS = UIButton(frame: CGRect(x: 40, y: 5, width: 60, height: 60))
        buttonFS.layer.masksToBounds = true
        let image = UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .medium))
        buttonFS.setImage(image, for: .normal)
        buttonFS.tintColor = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
        buttonFS.addTarget(self, action: #selector(moveToMySchedule), for: .touchUpInside)
        return buttonFS
    }()
    private let buttonSettings: UIButton = {
        //Creating a floating button
        let buttonFS = UIButton(frame: CGRect(x: 40, y: 5, width: 60, height: 60))
        buttonFS.layer.masksToBounds = true
        let image = UIImage(systemName: "gear", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .medium))
        buttonFS.setImage(image, for: .normal)
        buttonFS.tintColor = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
        buttonFS.addTarget(self, action: #selector(moveToSettings), for: .touchUpInside)
        return buttonFS
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100.0
        self.tableView.delegate = self
        self.tableView.dataSource = self
        //tableView.contentInsetAdjustmentBehavior = .never
        self.tableView.tableHeaderView?.removeFromSuperview()
        self.tableView.layoutIfNeeded()
        //Configurator.configure(viewController: self)
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
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //Making scroll button stay in place
        let offset = scrollView.contentOffset.y
        bottomNavBar.frame = CGRect(x: 0, y: view.frame.size.height - 85 + offset, width: view.frame.size.width, height: 85)
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
    @objc func moveToMySchedule(sender: UIButton!) {
        output?.moveToMySchedule()
    }
    @objc func moveToSettings(sender: UIButton!) {
        output?.moveToSettings()
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
