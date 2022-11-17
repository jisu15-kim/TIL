//: [Previous](@previous)

import Foundation
import Combine


let subject = PassthroughSubject<String, Never>()

let subscription = subject
    .print()
    .sink { value in
        print("received value: \(value)")
    }

subject.send("Hello")
subject.send("swift")
subject.send("ohoh")
subject.send(completion: .finished)
subject.send("hi")

subscription.cancel()

//: [Next](@next)
