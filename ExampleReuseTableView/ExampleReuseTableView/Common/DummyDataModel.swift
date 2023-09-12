//
//  DummyDataModel.swift
//  ExampleReuseTableView
//
//  Created by 김지수 on 2023/09/13.
//

import Foundation

// MARK: - User
struct User: Codable {
    let results: [UserResult]
    let info: Info
}

// MARK: - Info
struct Info: Codable {
    let seed: String
    let results: Int
    let page: Int
    let version: String
}

// MARK: - Result
struct UserResult: Codable {
    let name: Name
    let email: String
    let picture: Picture
}

// MARK: - Name
struct Name: Codable {
    let title, first, last: String
}

// MARK: - Picture
struct Picture: Codable {
    let large, medium, thumbnail: String
}
