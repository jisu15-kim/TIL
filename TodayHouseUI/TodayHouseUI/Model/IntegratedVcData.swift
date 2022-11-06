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

enum SearchViewCategory: CaseIterable {
    case photo
    case houseWarming
    case knowHow
    case store
    case qna
    case interiorStore
}

struct RecommandSearchKeyword {
    var title: String
    var qna: [QnARecommandModel]?
    var type: SearchViewCategory
}

enum QnARecommandSection {
    case normal
    case section
    case furniture
    case space
    case wide
    case interior
    case ect
}

struct QnARecommandModel {
    var title: String
    var type: QnARecommandSection
}
