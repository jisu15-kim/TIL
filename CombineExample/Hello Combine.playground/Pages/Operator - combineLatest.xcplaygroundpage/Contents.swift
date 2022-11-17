//: [Previous](@previous)

import Foundation
import Combine


// Basic CombineLatest
let strPublisher = PassthroughSubject<String, Never>()
let numPublisher = PassthroughSubject<Int, Never>()

strPublisher.combineLatest(numPublisher)
    .sink { (string, num) in
        print("Receive: \(string), \(num)")
    }

strPublisher.send("a")
strPublisher.send("b")
strPublisher.send("c")

numPublisher.send(1)
numPublisher.send(2)
numPublisher.send(3)

strPublisher.send("d")

numPublisher.send(4)
numPublisher.send(5)

// Advanced CombineLatest

let usernamePublisher = PassthroughSubject<String, Never>()
let passwordPublisher = PassthroughSubject<String, Never>()

let validatedCrendetialsSubscription = usernamePublisher.combineLatest(passwordPublisher)
    .map { (username, password) -> Bool in
        return !username.isEmpty && password.count > 12
    }
    .sink { valid in
        print("Credential valid? : \(valid)")
    }

usernamePublisher.send("JisuKim")
passwordPublisher.send("weakPw")
passwordPublisher.send("reallyStringPassword")


// Merge

let publisher1 = [1, 2, 3, 4, 5].publisher
let publisher2 = [300, 400, 500].publisher
// 두가지 Publisher의 타입이 같아야 Merge 가능함
let mergedPublisherSubscription = publisher1.merge(with: publisher2)
    .sink { value in
        print("Merge: \(value)")
    }


//: [Next](@next)
