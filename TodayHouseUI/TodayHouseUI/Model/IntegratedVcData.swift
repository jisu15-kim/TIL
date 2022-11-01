//
//  SearchViewModel.swift
//  TodayHouseUI
//
//  Created by 김지수 on 2022/11/01.
//

import UIKit

enum SearchViewCellType: CaseIterable {
    case hot
    case categoryFind
    case areaFind
    case imageKeyword
    case houseType
    case recommandGuideBook
    case recommandKeyword
}

struct IntegratedVcData {
    var image: UIImage?
    var title: String
    var description: String?
    var type: SearchViewCellType
}
