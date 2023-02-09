//: [Previous](@previous)

import Foundation


func solution(_ M:Int, _ N:Int) -> Int {
    
    let mCount = M - 1
    let nCount = N - 1
    
    return M * nCount + mCount
}

print(solution(1, 1))


