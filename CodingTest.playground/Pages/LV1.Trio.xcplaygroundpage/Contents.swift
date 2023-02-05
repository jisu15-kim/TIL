import Foundation

func solution(_ number:[Int]) -> Int {
    
    for (index, element) in number.enumerated() {
//        print("index: \(index), element: \(element)")
        
        var filteredNumber = number
        filteredNumber.remove(at: index)
        
        for (index, element) in filteredNumber.enumerated() {
            
            var secondFilteredNumber = filteredNumber
            secondFilteredNumber.remove(at: index)
            
            for (index, element) in secondFilteredNumber.enumerated() {
                
                var thirdFilteredNumber = secondFilteredNumber
                thirdFilteredNumber.remove(at: index)
                
                print(thirdFilteredNumber)
            }
        }
    }
    
    
    
    return 0
}

solution([-3, -2, -1, 0, 1, 2, 3])
