//
//  NetworkModels.swift
//  MarsRoverPhotos
//
//  Created by Liza on 02.10.2023.
//

import Foundation
struct Photos: Codable {
    var photos: [Photo]
}

struct Photo: Codable {
    let id: Int
    let camera: PhotoCameraResponse
    let imgSrc: String
    let earthDate: String
    let rover: RoverResponse

    enum CodingKeys: String, CodingKey {
        case id, camera
        case imgSrc = "img_src"
        case earthDate = "earth_date"
        case rover
    }
}

struct PhotoCameraResponse: Codable {
    let id: Int
    let name: String
    let fullName: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case fullName = "full_name"
    }
}

struct RoverResponse: Codable {
    let name, status: String
    let maxDate: String

    enum CodingKeys: String, CodingKey {
        case name
        case status
        case maxDate = "max_date"
    }
}


struct RoverManifest: Codable {
    var photoManifest: RoverResponse
    enum CodingKeys: String, CodingKey {
        case photoManifest = "photo_manifest"
    }
}
