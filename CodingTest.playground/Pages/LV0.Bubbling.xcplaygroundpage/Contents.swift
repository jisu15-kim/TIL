import UIKit

var greeting = "Hello, playground"


class Solution {
    
    let aya = "aya"
    let ye = "ye"
    let woo = "woo"
    let ma = "ma"
    
    let checkWord = ["aya", "ye", "woo", "ma"]
    
    func solution(_ babbling:[String]) -> Int {
        var matchedCount = 0
        babbling.forEach{ string in
            if stringCheck(word: string) == true {
                matchedCount += 1
            }
        }
        return matchedCount
    }
    
    func stringCheck(word: String) -> Bool {
        var matched: [String] = []
        for check in checkWord {
            if word.contains(check) {
                matched.append(check)
            }
        }
        var matchedCount = 0
        matched.forEach{
            matchedCount += $0.count
        }
        if word.count == matchedCount {
            return true
        }
        return false
    }
}
