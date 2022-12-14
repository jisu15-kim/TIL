//
//  MainModel.swift
//  TodayHouseUI
//
//  Created by 김지수 on 2022/10/23.
//

import UIKit

struct MainModel {
    var ad: [AD]
    var category: [Category]
    var recommandation: [Recommandation]
    var tips: [Tips]
    var find: [Find]
}

struct AD {
    var image: UIImage?
}

struct Category {
    var image: UIImage?
    var title: String
}

struct Recommandation {
    var image: UIImage?
    var description: String
}

struct Tips {
    var image: UIImage?
    var description: String
}

struct Find {
    var image: UIImage?
    var title: String
}
