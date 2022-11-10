//
//  ProductModel.swift
//  CarrotCloneFirebase
//
//  Created by 김지수 on 2022/11/09.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Product: Codable {
    
    @DocumentID var documentID: String?
    var title: String
    var region: String
    var upLoadTime: String
    var price: Int
    var body: String
//
//    init?(data: [String: Any]) {
//
//        guard let title = data["title"] as? String,
//              let region = data["region"] as? String,
//              let upLoadTime = data["upLoadTime"] as? String,
//              let price = data["price"] as? Int,
//              let body = data["body"] as? String else { return nil }
//        self.title = title
//        self.region = region
//        self.upLoadTime = upLoadTime
//        self.price = price
//        self.body = body
//    }
}
