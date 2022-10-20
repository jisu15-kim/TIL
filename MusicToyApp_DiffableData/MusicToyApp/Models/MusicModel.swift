//
//  MusicModel.swift
//  MusicToyApp
//
//  Created by 김지수 on 2022/10/18.
//

import UIKit

struct Music: Hashable {
    var id = UUID()
    var musicDetail: [MusicDetail]
}

struct MusicDetail: Hashable {
    let id = UUID()
    let title: String
    let artist: String
    let image: UIImage?
}
