//: [Previous](@previous)

import Foundation
import Combine
import UIKit


// 서버에서 데이터를 받을 때
// URLSessionTask Publisher and JSON Decoding Operator
struct SomeDecodable: Decodable {
    
}

let url = URL(string: "https://www.google.com")
URLSession.shared.dataTaskPublisher(for: url!)
    .map { data, response in
        return data
    }
    .decode(type: SomeDecodable.self, decoder: JSONDecoder())


// Notifications

let center = NotificationCenter.default
let noti = Notification.Name("MyNoti")
let notiPublisher = center.publisher(for: noti, object: nil)
let subscription = notiPublisher.sink { _ in
    print("Noti Received")
}




// KeyPath binding to NSObject instances



// Timer
// autoconnect 를 이용하면 subscribe 되면 바로 시작함


//: [Next](@next)
