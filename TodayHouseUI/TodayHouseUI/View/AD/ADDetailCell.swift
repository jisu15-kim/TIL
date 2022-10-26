//
//  ADDetailCell.swift
//  TodayHouseUI
//
//  Created by 김지수 on 2022/10/23.
//

import UIKit

class ADDetailCell: UICollectionViewCell {
    
    @IBOutlet weak var bannerImage: UIImageView!
    var ad: AD?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure() {
        bannerImage.image = ad?.image
    }
    
    func setupUI() {
//        bannerImage.layer.cornerRadius = 20
//        bannerImage.clipsToBounds = true
    }
}
