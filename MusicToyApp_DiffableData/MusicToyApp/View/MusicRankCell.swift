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
    }
    
    func configure() {
        guard let safeData = music else { return }

        musicImage.image = safeData.image
        musicArtist.text = safeData.artist
        musicImage.layer.cornerRadius = 10
        musicTitle.text = safeData.title
        musicTitle.textColor = .white
        musicArtist.contentMode = .scaleAspectFill
    }

}
