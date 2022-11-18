//
//  UIBarButtonItem+CustomView.swift
//  CarrotHomeTab
//
//  Created by 김지수 on 2022/11/19.
//

import Foundation
import UIKit

extension UIBarButtonItem {
    static func generate(with config: CustomBarItemConfiguration, width: CGFloat? = nil) -> UIBarButtonItem {
        
        let customView = CustomBarItem(config: config)
        if let width = width {
            customView.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        let barButtonItem = UIBarButtonItem(customView: customView)
        return barButtonItem
    }
}
