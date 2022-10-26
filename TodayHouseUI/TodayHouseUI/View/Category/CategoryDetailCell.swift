//
//  CategoryDetailCell.swift
//  TodayHouseUI
//
//  Created by 김지수 on 2022/10/23.
//

import UIKit

class CategoryDetailCell: UICollectionViewCell {
    
    var category: Category?

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setupUI() {
        self.backView.layer.cornerRadius = 10
    }
    
    func configure() {
        titleLabel.text = category?.title
        image.image = category?.image
    }

}
