//
//  String.swift
//  MarsRoverPhotos
//
//  Created by Liza on 03.10.2023.
//

import Foundation

extension String {
    func getDate() -> Date? {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        let date = dateFormater.date(from: self)
        return date
    }
    func formattedDateString() -> String? {
        guard  let date = self.getDate() else {
            return nil
        }
        return date.getFullFormString()
    }
}
