//
//  PhotoModel.swift
//  MarsRoverPhotos
//
//  Created by Liza on 03.10.2023.
//

import Foundation

protocol PhotoModel {
    var camera: String {get}
    var rover: String {get}
    var imageName: String {get}
    var date: String {get}
}
struct Photo: PhotoModel {
    var camera: String
    
    var rover: String
    
    var imageName: String
    
    var date: String
    
}
