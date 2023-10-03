//
//  PhotoCellModel.swift
//  MarsRoverPhotos
//
//  Created by Liza on 03.10.2023.
//

import UIKit

protocol PhotoCellModelProtocol {
    var roverText: NSMutableAttributedString { get }
    var cameraText: NSMutableAttributedString { get }
    var dateText: NSMutableAttributedString { get }
    var imageURL: URL? { get }
    init(photoModel: PhotoModel)
}

class PhotoCellViewModel: PhotoCellModelProtocol {
    
    var roverText: NSMutableAttributedString {
        return attributedText(regularText: "Rover: ", boldText: roverType)
    }
    
    var cameraText: NSMutableAttributedString {
        return attributedText(regularText: "Camera: ", boldText: cameraType)
    }
    
    var dateText: NSMutableAttributedString {
        return attributedText(regularText: "Date: " , boldText: date)
    }
    var imageURL: URL? {
        return URL(string: imageName)
    }
    
    private var roverType: String
    
    private var cameraType: String
    
    private var imageName: String
    
    private var date: String
    
    
    required init(photoModel: PhotoModel) {
        self.roverType = photoModel.rover
        self.cameraType = photoModel.camera
        self.date = photoModel.date.formattedDateString() ?? ""
        self.imageName = photoModel.imageName
        
    }
    
    func attributedText(regularText: String, boldText: String) -> NSMutableAttributedString {
        let regularAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.bodyFont, .foregroundColor: UIColor.layerTwo]
        let attributedText = NSMutableAttributedString(string: regularText, attributes: regularAttributes)
        let boldAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.bodyTwoFont, .foregroundColor: UIColor.layerOne]
        attributedText.append(NSAttributedString(string: boldText, attributes: boldAttributes))
        return attributedText
    }
    
}
