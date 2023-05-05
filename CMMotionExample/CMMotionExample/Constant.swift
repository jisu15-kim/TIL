//
//  Constant.swift
//  CMMotionExample
//
//  Created by 김지수 on 2023/05/03.
//

import Foundation

struct Constant {
    static let updateInterval: TimeInterval = 1.0 / 10.0
    static var decimalFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 1
        formatter.minimumIntegerDigits = 1
        return formatter
    }()
}
