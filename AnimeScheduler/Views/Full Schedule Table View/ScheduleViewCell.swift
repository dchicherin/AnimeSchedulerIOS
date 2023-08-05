//
//  ScheduleViewCell.swift
//  OTUSAPI
//
//  Created by Dmitry Chicherin on 13/7/2566 BE.
//

import UIKit

class ScheduleViewCell: UITableViewCell {

    @IBOutlet weak var viewInfoButton: UIButton!
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var TimeLabel: UILabel!
    @IBOutlet weak var NameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setup(withScheduleItem: SchedulePosition, imageToShow: UIImage?){
        //Отрисовка инфы в ячейках
        NameLabel.text = withScheduleItem.title
        TimeLabel.text = "\(withScheduleItem.broadcast?.day ?? "Date unknown")  \(withScheduleItem.broadcast?.time ?? "??")"
        ImageView.image = imageToShow
    }

}
