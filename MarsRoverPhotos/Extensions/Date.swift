//
//  Date.swift
//  MarsRoverPhotos
//
//  Created by Liza on 03.10.2023.
//

import Foundation

extension Date {
    func days(sinceDate: Date) -> Int? {
        let calendar = Calendar.current
        let fromDate = calendar.startOfDay(for: sinceDate)
        let toDate = calendar.startOfDay(for: self)
        guard
            let days = Calendar.current.dateComponents([.day], from: fromDate, to: toDate).day
        else {
            return nil
        }
        return days + 1
    }
    func getString(format: String) -> String? {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = format
        return dateFormater.string(from: self)
    }
    func getShortFormString() -> String? {
        getString(format: "yyyy-MM-dd")
    }
    func getFullFormString() -> String? {
        getString(format: "MMMM d, yyyy")
    }
}

