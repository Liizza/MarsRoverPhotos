//
//  CGColor.swift
//  MarsRoverPhotos
//
//  Created by Liza on 03.10.2023.
//

import UIKit

extension CGColor {
    static func shadowColor(alpha: CGFloat) -> CGColor {
        let color = UIColor(red: 0, green: 0, blue: 0, alpha: alpha).cgColor
        return color
    }
}
