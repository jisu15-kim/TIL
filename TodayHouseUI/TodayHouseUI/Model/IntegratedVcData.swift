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

enum QnARecommandSection: String, CaseIterable {
    case normal = "일반"
    case section = "부분 공정"
    case furniture = "가구"
    case space = "공간"
    case wide = "평수"
    case interior = "실내 공간"
    case ect = "기타"
}

struct QnARecommandModel {
    var title: String
    var type: QnARecommandSection
}
