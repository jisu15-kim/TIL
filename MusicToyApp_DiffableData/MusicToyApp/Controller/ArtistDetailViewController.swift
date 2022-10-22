//
//  ArtistDetailViewController.swift
//  MusicToyApp
//
//  Created by 김지수 on 2022/10/22.
//

import UIKit

final class ArtistDetailViewController: UIViewController {

    @IBOutlet weak var artistImage: UIImageView!
    @IBOutlet weak var artistName: UILabel!
    
    var newArtist: NewArtist?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        artistImage.image = newArtist?.image
        artistName.text = newArtist?.name
        view.backgroundColor = .black
        artistName.textColor = .white
        artistName.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
}
