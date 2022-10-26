//
//  DataManager.swift
//  TodayHouseUI
//
//  Created by 김지수 on 2022/10/23.
//

import UIKit


class DataManager {
    
    var mainModel: MainModel?
    
    private func fetchData() {
        
        let category = [
        Category(image: UIImage(named: "apron"), title: "쇼핑하기"),
        Category(image: UIImage(named: "chest"), title: "오!굿즈"),
        Category(image: UIImage(named: "closet"), title: "오늘의딜"),
        Category(image: UIImage(named: "desk lamp"), title: "오늘뭐하지"),
        Category(image: UIImage(named: "door handle"), title: "식품관"),
        Category(image: UIImage(named: "fireplace"), title: "집들이"),
        Category(image: UIImage(named: "lamp_2"), title: "꿀잼시리즈"),
        Category(image: UIImage(named: "lamp"), title: "빠른배송"),
        Category(image: UIImage(named: "microwave"), title: "쉬운이사"),
        Category(image: UIImage(named: "mirror"), title: "리모델링")
        ]
        
        let ad = [
        AD(image: UIImage(named: "ad01")),
        AD(image: UIImage(named: "ad02")),
        AD(image: UIImage(named: "ad03")),
        AD(image: UIImage(named: "ad04")),
        AD(image: UIImage(named: "ad05")),
        AD(image: UIImage(named: "ad06"))
        ]
        
        let rec = [
        Recommandation(image: UIImage(named: "Rec01"), description: "정갈하고 단정한 출발을 위한 새내기 부부의 신축 아파트"),
        Recommandation(image: UIImage(named: "Rec02"), description: "깔끔한데 포인트도 있다! 디자이너의 14평 오피스텔"),
        Recommandation(image: UIImage(named: "Rec03"), description: "전지적 냥시점, 냥이와 집사를 위한 원룸 인테리어"),
        Recommandation(image: UIImage(named: "Rec04"), description: "거실, 침실, 작업실 그리고 드레스룸까지 있는 1.5룸")
        ]
        
        mainModel = MainModel(ad: ad, category: category, recommandation: rec)
    }
    
    public func getData() -> MainModel? {
        fetchData()
        return mainModel
    }
    
}
