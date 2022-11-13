//
//  TextCell.swift
//  exFirestoreApp
//
//  Created by 김지수 on 2022/11/11.
//

import UIKit

class TextCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    var data: Message?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure() {
        self.titleLabel.text = self.data?.content
    }

}
