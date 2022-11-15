//
//  Message.swift
//  exFirestoreApp
//
//  Created by 김지수 on 2022/11/10.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Message: Codable {
    
    @DocumentID var docId: DocumentReference?
//    @DocumentID var docId: String?
    
    let id: String
    let content: String
    let sentDate: Date
    
    init(id: String, content: String, docId: DocumentReference?) {
        self.id = id
        self.content = content
        self.sentDate = Date()
        self.docId = docId
    }
    // MARK: - Date 형을 firestore에 입력하면 Unix Time Stamp형으로 변환하는 작업
    
    private enum CodingKeys: String, CodingKey {
        case docId
        case id
        case content
        case sentDate
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
//        docId = try values.decode(String.self, forKey: .docId)
        id = try values.decode(String.self, forKey: .id)
        content = try values.decode(String.self, forKey: .content)
        docId = try values.decode(DocumentID<DocumentReference>.self, forKey: .docId).wrappedValue
        let dataDouble = try values.decode(Double.self, forKey: .sentDate)
        sentDate = Date(timeIntervalSince1970: dataDouble)
    }
}


extension Message: Comparable {
    
    static func == (lhs: Message, rhs: Message) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func < (lhs: Message, rhs: Message) -> Bool {
        return lhs.sentDate == rhs.sentDate
    }
}
