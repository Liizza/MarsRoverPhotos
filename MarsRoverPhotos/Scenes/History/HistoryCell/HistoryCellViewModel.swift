//
//  HistoryCellViewModel.swift
//  MarsRoverPhotos
//
//  Created by Liza on 04.10.2023.
//

import UIKit

protocol HistoryCellViewModelProtocol {
    var roverText: NSMutableAttributedString { get }
    var cameraText: NSMutableAttributedString { get }
    var dateText: NSMutableAttributedString { get }
}

class HistoryCellViewModel: HistoryCellViewModelProtocol {
    
    var roverText: NSMutableAttributedString {
        return attributedText(regularText: "Rover: ", boldText: roverType)
    }
    
    var cameraText: NSMutableAttributedString {
        return attributedText(regularText: "Camera: ", boldText: cameraType)
    }
    
    var dateText: NSMutableAttributedString {
        return attributedText(regularText: "Date: " , boldText: date)
    }
    private var roverType: String {
        return filterModel.roverEnum.fullName
    }
    
    private var cameraType: String {
        return filterModel.cameraEnum.fullName
    }
    
    private var date: String {
        return filterModel.date.getFullFormString() ?? ""
    }
    private var filterModel: RealmFiltersModel
    
    init(filterModel: RealmFiltersModel) {
        self.filterModel = filterModel
    }
    
    func attributedText(regularText: String, boldText: String) -> NSMutableAttributedString {
        let regularAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.bodyFont, .foregroundColor: UIColor.layerTwo]
        let attributedText = NSMutableAttributedString(string: regularText, attributes: regularAttributes)
        let boldAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.bodyTwoFont, .foregroundColor: UIColor.layerOne]
        attributedText.append(NSAttributedString(string: boldText, attributes: boldAttributes))
        return attributedText
    }
}
