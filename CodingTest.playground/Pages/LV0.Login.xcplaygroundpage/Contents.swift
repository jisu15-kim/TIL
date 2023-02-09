//: [Previous](@previous)

import Foundation

func solution(_ id_pw:[String], _ db:[[String]]) -> String {
    
    var isIDExist = false
    var isValidated = false
    
    for account in db {
        if id_pw[0] == account[0] {
            isIDExist = true
            if id_pw[1] == account[1] {
                isValidated = true
            }
        }
    }
    
    if isIDExist == true && isValidated == true {
        return "login"
    } else if isIDExist == true && isValidated == false {
        return "wrong pw"
    } else {
        return "fail"
    }
}


solution(["programmer01", "15789"], [["programmer02", "111111"], ["programmer00", "134"], ["programmer01", "1145"]])
