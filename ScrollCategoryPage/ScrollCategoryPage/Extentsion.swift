//
//  Extentsion.swift
//  ScrollCategoryPage
//
//  Created by 김지수 on 2022/10/31.
//
import UIKit

extension UIView {
    
    func makeRounded(radius: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
    }
    
    func makeRoundedWithBorder(radius: CGFloat, color: CGColor) {
        makeRounded(radius: radius)
        self.layer.borderWidth = 1
        self.layer.borderColor = color
    }
  
}
