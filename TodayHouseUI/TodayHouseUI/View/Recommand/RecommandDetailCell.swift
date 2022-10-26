//
//  RecommandDetailCell.swift
//  TodayHouseUI
//
//  Created by 김지수 on 2022/10/26.
//

import UIKit

final class RecommandDetailCell: UICollectionViewCell {
    
    var recommandation: Recommandation?
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure() {
        image.image = recommandation?.image
        descriptionLabel.text = recommandation?.description
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
    }

}
