//: [Previous](@previous)

import Foundation
import Combine

let arrayPublisher = [1, 2, 3, 4].publisher

let queue = DispatchQueue(label: "custom")

let subscription = arrayPublisher
    .subscribe(on: queue)
    // 만약 Heavy한 작업일 경우, 메인 스레드가 아닌 타 스레드에서 처리
    .map{ value in
        print("transform \(value), thread: \(Thread.current)")
        return value
    }
    // 다시 메인 스레드에서 받음
    .receive(on: DispatchQueue.main)
    .sink { value in
    print("received value: \(value), thread: \(Thread.current)")
}

//: [Next](@next)
