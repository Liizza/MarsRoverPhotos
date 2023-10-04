//
//  API.swift
//  MarsRoverPhotos
//
//  Created by Liza on 02.10.2023.
//

import Foundation

protocol ApiData {
    var apiKey: URLQueryItem { get }
    var baseURL: URL? { get }
    func roversPhotosURL(roverType: RoverType, photoQueries: [PhotoQueries]) -> URL?
}

struct NasaApiData: ApiData {
    let apiKey = URLQueryItem(name: "api_key", value: "67e198S2REK62r6zXOPAbLsSKiUbPqLmXoScQ0jK")
    let baseURL = URL(string: "https://api.nasa.gov/")
    func roversPhotosURL(roverType: RoverType, photoQueries: [PhotoQueries]) -> URL? {
        var queries = photoQueries.map { $0.queryItem }
        queries.append(apiKey)
        var url = baseURL?.appending(path: "mars-photos/api/v1/rovers/\(roverType.rawValue)/photos").appending(queryItems: queries)
        return url
    }
}
enum PhotoQueries {
    case camera(CameraType)
    case earthDate(String)
    var queryItem: URLQueryItem {
        switch self {
        case .camera(let cameraType):
            return URLQueryItem(name: "camera", value: cameraType.rawValue)
        case .earthDate(let date):
            return URLQueryItem(name: "earth_date", value: date)
        }
    }
}

