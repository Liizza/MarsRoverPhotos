//
//  PhotoViewViewModel.swift
//  MarsRoverPhotos
//
//  Created by Liza on 05.10.2023.
//

import Foundation

protocol PhotoViewModelProtocol {
    var imageURL: URL? { get }
    init(imageName: String)
}
class PhotoViewViewModel: PhotoViewModelProtocol {
    var imageURL: URL? {
        return URL(string: imageName)
    }
    private var imageName: String
    
    required init(imageName: String) {
        self.imageName = imageName
    }
}
