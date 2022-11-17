//: [Previous](@previous)

import Foundation
import UIKit
import Combine

final class SomeViewModle {
    // 퍼블리셔로 만들어줌
    // 업데이트가 되는 퍼블리셔를 만들어줌
    @Published var name: String = "Jack"
    var age: Int = 20
}

final class Label {
    var text: String = ""
}


let label = Label()
let vm = SomeViewModle()
print("text: \(label.text)")

// 퍼블리셔 Subscribe
vm.$name.assign(to: \.text, on: label)
print("text: \(label.text)")

vm.name = "jisu"
print("text: \(label.text)")

// label 의 text 프로퍼티를 vm의 텍스트에 할당한다

//: [Next](@next)
