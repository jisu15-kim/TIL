//: [Previous](@previous)

import Foundation
import Combine

// Transform - Map
let numPublisher = PassthroughSubject<Int, Never>()
let subscription1 = numPublisher
    .map { $0 * 2 }
    .sink { value in
        print("Transformed Value : \(value)")
    }
numPublisher.send(10)
numPublisher.send(20)
numPublisher.send(30)
// Filter
let stringPublisher = PassthroughSubject<String, Never>()
let subscription2 = stringPublisher
    .filter { $0.contains("a") }
    .sink { value in
        print("\(value)")
    }

stringPublisher.send("abc")
stringPublisher.send("vds")
stringPublisher.send("avd")

//: [Next](@next)
