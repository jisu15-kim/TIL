//
//  MusicModel.swift
//  MusicToyApp
//
//  Created by 김지수 on 2022/10/18.
//

import UIKit

struct NewArtist: Hashable {
    let name: String
    let image: UIImage
}

struct MusicDetail: Hashable {
    let id = UUID()
    let title: String
    let artist: String
    let image: UIImage?
}

struct PlayList: Hashable {
    let id = UUID()
    let title: String
    let image: UIImage?
}
