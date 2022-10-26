//
//  GridCollectionView.swift
//  TodayHouseUI
//
//  Created by 김지수 on 2022/10/24.
//

import UIKit

class GridCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    var ratioHeightToWidth = 1.0
    var numberOfColumns = 1
    var cellSpacing = 0.0 {
        didSet {
            self.minimumLineSpacing = self.cellSpacing
            self.minimumInteritemSpacing = self.cellSpacing
        }
    }
    
    override init() {
        super.init()
        self.scrollDirection = .vertical
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
}
