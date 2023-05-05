//
//  MotionModel.swift
//  CMMotionExample
//
//  Created by 김지수 on 2023/05/04.
//

import Foundation

struct MotionModel: Codable {
    let eulerRotation: EulerRotation
    let quaternion: Quaternion
}

struct EulerRotation: Codable {
    let x: Double
    let y: Double
    let z: Double
}

struct Quaternion: Codable {
    let x: Double
    let y: Double
    let z: Double
    let w: Double
}
