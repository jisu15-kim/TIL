//
//  DataCell.swift
//  NetworkTest
//
//  Created by 김지수 on 2022/12/27.
//

import UIKit

class DataCell: UITableViewCell {
    
    @IBOutlet weak var userID: UILabel!
    @IBOutlet weak var ID: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var model: Model?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure() {
        if let safeModel = model {
            userID.text = "\(safeModel.userId)"
            ID.text = "\(safeModel.id!)"
            titleLabel.text = safeModel.title
            descriptionLabel.text = safeModel.body
        }
    }

}
