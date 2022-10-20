//
//  MusicRankCell.swift
//  MusicToyApp
//
//  Created by 김지수 on 2022/10/18.
//

import UIKit

class MusicRankCell: UICollectionViewCell {

    @IBOutlet weak var musicImage: UIImageView!
    @IBOutlet weak var musicArtist: UILabel!
    @IBOutlet weak var musicTitle: UILabel!
    
    var music: MusicDetail?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure() {
        musicImage.image = music?.image
        musicArtist.text = music?.artist
        musicArtist.text = music?.title
    }

}
