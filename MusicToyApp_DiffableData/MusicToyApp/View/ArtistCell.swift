//
//  ArtistCell.swift
//  MusicToyApp
//
//  Created by 김지수 on 2022/10/18.
//

import UIKit

class ArtistCell: UICollectionViewCell {
    
    @IBOutlet weak var artistImage: UIImageView!
    @IBOutlet weak var artistName: UILabel!
    
    
    var newArtist: NewArtist?
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func setupUI() {
        artistName.text = newArtist?.name
        artistImage.image = newArtist?.image
        artistName.textColor = .white
        artistImage.layer.cornerRadius = artistImage.frame.width / 2
        artistImage.clipsToBounds = true
    }
    
    
    
}
