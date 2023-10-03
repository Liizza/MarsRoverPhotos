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
}
