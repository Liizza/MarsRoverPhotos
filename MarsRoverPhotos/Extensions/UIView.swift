//
//  UIView.swift
//  MarsRoverPhotos
//
//  Created by Liza on 03.10.2023.
//

import UIKit

extension UIView {
    func addShadow(width: CGFloat, height: CGFloat, color: CGColor, radius: CGFloat = 0, opacity: Float = 1) {
        self.layer.shadowColor = color
        self.layer.shadowOffset = CGSize(width: width, height: height)
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
    }
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
         let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
         let mask = CAShapeLayer()
         mask.path = path.cgPath
         layer.mask = mask
     }
    
}
