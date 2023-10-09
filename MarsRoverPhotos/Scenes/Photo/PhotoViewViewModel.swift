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
        var urlComponents = URLComponents(string: imageName)
        urlComponents?.scheme = "https"
        return urlComponents?.url
    }
    private var imageName: String
    
    required init(imageName: String) {
        self.imageName = imageName
    }
}
