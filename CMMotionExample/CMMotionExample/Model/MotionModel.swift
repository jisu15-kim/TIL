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
    let x: Float
    let y: Float
    let z: Float
}

struct Quaternion: Codable {
    let x: Float
    let y: Float
    let z: Float
    let w: Float
}
