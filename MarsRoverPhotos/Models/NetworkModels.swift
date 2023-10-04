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
    /*let roverID: Int*/
    let fullName: String

    enum CodingKeys: String, CodingKey {
        case id, name
        /*case roverID = "rover_id"*/
        case fullName = "full_name"
    }
}

struct RoverResponse: Codable {
    let id: Int
    let name/*, landingDate, launchDate, status*/: String
    /*let maxSol: Int
    let maxDate: String
    let totalPhotos: Int
    let cameras: [CameraResponse]*/

    enum CodingKeys: String, CodingKey {
        case id, name
        /*case landingDate = "landing_date"
        case launchDate = "launch_date"
        case status
        case maxSol = "max_sol"
        case maxDate = "max_date"
        case totalPhotos = "total_photos"
        case cameras*/
    }
}

/*struct CameraResponse: Codable {
    let name, fullName: String

    enum CodingKeys: String, CodingKey {
        case name
        case fullName = "full_name"
    }
}*/
