import Foundation
import Combine

// PassthroughSubject
let relay = PassthroughSubject<String, Never>()
let subscription1 = relay.sink { value in
    print("subscription value : \(value)")
}

relay.send("Hello")
relay.send("swift")

// CurrentValueSubject

let variable = CurrentValueSubject<Int, Never>(0) // 초기값 넣어줘여 함
variable.send(2)
let subscription2 = variable.sink { value in
    print("subscription2 value: \(value)")
}

variable.send(5)


let publisher = ["here", "we", "go"].publisher
publisher.subscribe(relay)
