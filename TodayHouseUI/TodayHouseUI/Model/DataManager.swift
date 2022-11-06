//
//  DataManager.swift
//  TodayHouseUI
//
//  Created by 김지수 on 2022/10/23.
//

import UIKit


class DataManager {
    
    private var mainModel: MainModel?
    private var dataList: [String] = []
    private var integratedVcData: [IntegratedVcData] = []
    private var recommandSearchKeywordData: [RecommandSearchKeyword] = []
    private var qnaData: [QnARecommandModel] = []
    
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
        
        let tips = [
            Tips(image: UIImage(named: "Tips01"), description: "침대 배치에 따라 달라지는 침실 분위기 3"),
            Tips(image: UIImage(named: "Tips02"), description: "키보드에만 100만원 슨 매니아의 추천 6 ⌨️"),
            Tips(image: UIImage(named: "Tips03"), description: "SNS에서 보던 예쁜 키보드, 어떻게 만드는 걸까? ⌨️"),
            Tips(image: UIImage(named: "Tips04"), description: "몇 번을 사도 다시 살, 만족도 💯 내돈내산 살림잇템 8")
        ]
        
        let find = [
            Find(image: UIImage(named: "find01"), title: "쇼파"),
            Find(image: UIImage(named: "find02"), title: "캠핑용품"),
            Find(image: UIImage(named: "find03"), title: "실내운동"),
            Find(image: UIImage(named: "find04"), title: "반려동물"),
            Find(image: UIImage(named: "find05"), title: "유아용품"),
            Find(image: UIImage(named: "find06"), title: "생필품"),
            Find(image: UIImage(named: "find07"), title: "수납용품"),
            Find(image: UIImage(named: "find08"), title: "식물"),
            Find(image: UIImage(named: "find09"), title: "주방용품"),
            Find(image: UIImage(named: "find10"), title: "냉장고"),
            Find(image: UIImage(named: "find11"), title: "침대")
        ]
        
        mainModel = MainModel(ad: ad, category: category, recommandation: rec, tips: tips, find: find)
    }
    
    private func fetchCategoryData() {
        dataList = ["통합", "사진", "집들이", "노하우", "스토어", "질문과답변", "시공업체", "유저"]
    }
    
    public func getData() -> MainModel? {
        fetchData()
        return mainModel
    }
    
    public func getCategoryData() -> [String] {
        fetchCategoryData()
        return dataList
    }
    
    private func fetchIntegratedVCData() {
        integratedVcData = [
            IntegratedVcData(title: "인센스 홀더", type: .hot),
            IntegratedVcData(title: "카페 의자", type: .hot),
            IntegratedVcData(title: "인테리어 소품", type: .hot),
            IntegratedVcData(title: "구이바다", type: .hot),
            IntegratedVcData(title: "샤브샤브냄비", type: .hot),
            IntegratedVcData(title: "크롬캐스트", type: .hot),
            IntegratedVcData(title: "콘센트 가리개", type: .hot),
            IntegratedVcData(title: "템바보드", type: .hot),
            IntegratedVcData(title: "키보드", type: .hot),
            IntegratedVcData(title: "금고", type: .hot),
            
            IntegratedVcData(image: UIImage(named: "find01"), title: "유아・아동", description: nil, type: .categoryFind),
            IntegratedVcData(image: UIImage(named: "find02"), title: "반려동물", description: nil, type: .categoryFind),
            IntegratedVcData(image: UIImage(named: "find03"), title: "실내운동", description: nil, type: .categoryFind),
            IntegratedVcData(image: UIImage(named: "find04"), title: "캠핑용품", description: nil, type: .categoryFind),
            IntegratedVcData(image: UIImage(named: "find05"), title: "공구・DIY", description: nil, type: .categoryFind),
            IntegratedVcData(image: UIImage(named: "find06"), title: "인테리어시공", description: nil, type: .categoryFind),
            IntegratedVcData(image: UIImage(named: "find07"), title: "렌탈", description: nil, type: .categoryFind),
            
            IntegratedVcData(image: UIImage(named: "area01"), title: "원룸", description: nil, type: .areaFind),
            IntegratedVcData(image: UIImage(named: "area02"), title: "거실", description: nil, type: .areaFind),
            IntegratedVcData(image: UIImage(named: "area03"), title: "침실", description: nil, type: .areaFind),
            IntegratedVcData(image: UIImage(named: "area04"), title: "주방", description: nil, type: .areaFind),
            IntegratedVcData(image: UIImage(named: "area05"), title: "욕실", description: nil, type: .areaFind),
            IntegratedVcData(image: UIImage(named: "area06"), title: "아이방", description: nil, type: .areaFind),
            IntegratedVcData(image: UIImage(named: "area07"), title: "드레스룸", description: nil, type: .areaFind),
            IntegratedVcData(image: UIImage(named: "area08"), title: "서재&작업실", description: nil, type: .areaFind),
            IntegratedVcData(image: UIImage(named: "area09"), title: "베란다", description: nil, type: .areaFind),
            
            IntegratedVcData(title: "플랜테리어", type: .imageKeyword),
            IntegratedVcData(title: "책상", type: .imageKeyword),
            IntegratedVcData(title: "에어클라이너", type: .imageKeyword),
            IntegratedVcData(title: "청소", type: .imageKeyword),
            IntegratedVcData(title: "침구교체", type: .imageKeyword),
            IntegratedVcData(title: "스마트전구", type: .imageKeyword),
            
            IntegratedVcData(image: UIImage(named: "houseType01"), title: "원룸&오피스텔", description: nil, type: .houseType),
            IntegratedVcData(image: UIImage(named: "houseType02"), title: "아파트", description: nil, type: .houseType),
            IntegratedVcData(image: UIImage(named: "houseType03"), title: "빌라&연립", description: nil, type: .houseType),
            IntegratedVcData(image: UIImage(named: "houseType04"), title: "단독주택", description: nil, type: .houseType),
            IntegratedVcData(image: UIImage(named: "houseType05"), title: "싱글라이프", description: nil, type: .houseType),
            IntegratedVcData(image: UIImage(named: "houseType06"), title: "신혼부부", description: nil, type: .houseType),
            IntegratedVcData(image: UIImage(named: "houseType07"), title: "아기 있는 집", description: nil, type: .houseType),
            IntegratedVcData(image: UIImage(named: "houseType08"), title: "부모님과 함께", description: nil, type: .houseType),
            
            IntegratedVcData(image: UIImage(named: "guide01"), title: "전셋집 꾸미기 가이드북", description: "지금 이 순간을 가꾸는 100가지 방법", type: .recommandGuideBook),
            IntegratedVcData(image: UIImage(named: "guide02"), title: "신혼가구 쇼핑가이드북", description: "유부의 경험으로 아끼는 손품과 발품", type: .recommandGuideBook),
            IntegratedVcData(image: UIImage(named: "guide03"), title: "리모델링 가이드북", description: "치명적 실수 막는 31가지 핵심 노하우", type: .recommandGuideBook),
            IntegratedVcData(image: UIImage(named: "guide04"), title: "셀프인테리어 가이드북", description: "최소비용으로 도전하는 최고의 변신", type: .recommandGuideBook),
            
            IntegratedVcData(title: "원룸 꾸미기", type: .recommandKeyword),
            IntegratedVcData(title: "수납 노하우", type: .recommandKeyword),
            IntegratedVcData(title: "욕실 청소", type: .recommandKeyword),
            IntegratedVcData(title: "커튼 설치", type: .recommandKeyword),
            IntegratedVcData(title: "내돈내산 제품 리뷰", type: .recommandKeyword),
            IntegratedVcData(title: "반려동물과 함께", type: .recommandKeyword),
            IntegratedVcData(title: "아기가 있는 집", type: .recommandKeyword),
            IntegratedVcData(title: "공간DIY", type: .recommandKeyword),
            IntegratedVcData(title: "주방 리모델링", type: .recommandKeyword),
            IntegratedVcData(title: "구매가이드", type: .recommandKeyword),
        ]
    }
    
    public func getIntegratedVcDataList() -> [IntegratedVcData] {
        fetchIntegratedVCData()
        return integratedVcData
    }
    
    // Fetch RecommandKeyword Data
    private func fetchRkData() {
        recommandSearchKeywordData = [
            RecommandSearchKeyword(title: "화장대", type: .photo),
            RecommandSearchKeyword(title: "책상", type: .photo),
            RecommandSearchKeyword(title: "식탁", type: .photo),
            RecommandSearchKeyword(title: "러그", type: .photo),
            RecommandSearchKeyword(title: "드레스룸", type: .photo),
            RecommandSearchKeyword(title: "커튼", type: .photo),
            RecommandSearchKeyword(title: "책장", type: .photo),
            
            RecommandSearchKeyword(title: "화이트우드", type: .houseWarming),
            RecommandSearchKeyword(title: "복층 오피스텔", type: .houseWarming),
            RecommandSearchKeyword(title: "주방", type: .houseWarming),
            RecommandSearchKeyword(title: "원룸", type: .houseWarming),
            RecommandSearchKeyword(title: "1.5룸", type: .houseWarming),
            RecommandSearchKeyword(title: "투룸", type: .houseWarming),
            RecommandSearchKeyword(title: "공간분리", type: .houseWarming),
            
            RecommandSearchKeyword(title: "오늘의식탁", type: .knowHow),
            RecommandSearchKeyword(title: "습기", type: .knowHow),
            RecommandSearchKeyword(title: "가구추천", type: .knowHow),
            RecommandSearchKeyword(title: "홈카페", type: .knowHow),
            RecommandSearchKeyword(title: "파스텔", type: .knowHow),
            RecommandSearchKeyword(title: "레시피", type: .knowHow),
            RecommandSearchKeyword(title: "주방청소", type: .knowHow),
        ]
    }
    
    public func getRkData() -> [RecommandSearchKeyword] {
        fetchRkData()
        return recommandSearchKeywordData
    }
    
    private func fetchQnAData() {
        qnaData = [
            QnARecommandModel(title: "리모델링/올수리", type: .normal),
            QnARecommandModel(title: "견적", type: .normal),
            QnARecommandModel(title: "업체 추천", type: .normal),
            QnARecommandModel(title: "셀프 인테리어", type: .normal),
            QnARecommandModel(title: "신혼", type: .normal),
            QnARecommandModel(title: "리폼", type: .normal),
            QnARecommandModel(title: "디자인 추천", type: .normal),
            
            QnARecommandModel(title: "가벽", type: .section),
            QnARecommandModel(title: "단열", type: .section),
            QnARecommandModel(title: "도배", type: .section),
            QnARecommandModel(title: "마루", type: .section),
            QnARecommandModel(title: "목공", type: .section),
            QnARecommandModel(title: "몰딩", type: .section),
            QnARecommandModel(title: "바닥", type: .section),
            QnARecommandModel(title: "벽", type: .section),
            QnARecommandModel(title: "붙박이", type: .section),
            QnARecommandModel(title: "창호/창호", type: .section),
            QnARecommandModel(title: "수리/복구", type: .section),
            QnARecommandModel(title: "실리콘", type: .section),
            QnARecommandModel(title: "외관/외벽", type: .section),
            QnARecommandModel(title: "입주청소", type: .section),
            QnARecommandModel(title: "장판", type: .section),
            QnARecommandModel(title: "전기", type: .section),
            QnARecommandModel(title: "조명", type: .section),
            QnARecommandModel(title: "줄눈", type: .section),
            QnARecommandModel(title: "천장", type: .section),
            QnARecommandModel(title: "철거", type: .section),
            QnARecommandModel(title: "콘센트", type: .section),
            QnARecommandModel(title: "타일", type: .section),
            QnARecommandModel(title: "페인트", type: .section),
            QnARecommandModel(title: "필름", type: .section),
            QnARecommandModel(title: "기타공정", type: .section),
            QnARecommandModel(title: "기타청소", type: .section),
            
            QnARecommandModel(title: "가구배치/이동", type: .furniture),
            QnARecommandModel(title: "냉장고", type: .furniture),
            QnARecommandModel(title: "블라인드", type: .furniture),
            QnARecommandModel(title: "손잡이", type: .furniture),
            QnARecommandModel(title: "수전/싱크대", type: .furniture),
            QnARecommandModel(title: "소파", type: .furniture),
            QnARecommandModel(title: "식탁", type: .furniture),
            QnARecommandModel(title: "유리", type: .furniture),
            QnARecommandModel(title: "에어컨", type: .furniture),
            QnARecommandModel(title: "침대", type: .furniture),
            QnARecommandModel(title: "TV", type: .furniture),
            QnARecommandModel(title: "기타가구", type: .furniture),
            
            QnARecommandModel(title: "단독주택", type: .space),
            QnARecommandModel(title: "아파트", type: .space),
            QnARecommandModel(title: "상가", type: .space),
            QnARecommandModel(title: "원룸", type: .space),
            
            QnARecommandModel(title: "10평미만", type: .wide),
            QnARecommandModel(title: "10평대", type: .wide),
            QnARecommandModel(title: "20평대", type: .wide),
            QnARecommandModel(title: "30평대", type: .wide),
            QnARecommandModel(title: "40평대", type: .wide),
            QnARecommandModel(title: "50평이상", type: .wide),
            
            QnARecommandModel(title: "화장실", type: .interior),
            QnARecommandModel(title: "베란다", type: .interior),
            QnARecommandModel(title: "거실", type: .interior),
            QnARecommandModel(title: "주방", type: .interior),
            QnARecommandModel(title: "현관", type: .interior),
            
            QnARecommandModel(title: "기타", type: .ect),
        ]
    }
    
    public func getQnAData() -> [QnARecommandModel] {
        fetchQnAData()
        return qnaData
    }
}
