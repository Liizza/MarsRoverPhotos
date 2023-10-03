//
//  NetworkService.swift
//  MarsRoverPhotos
//
//  Created by Liza on 28.09.2023.
//

import Foundation
import Alamofire

protocol NetworkService {
    
    func getPhotos(roverType: RoverType,
                   cameraType: CameraType,
                   date: Date,
                   completionHandler: @escaping (Result<[Photo],Error>) -> Void)
}

class AlamofireNetworkService: NetworkService {
    var apiData: ApiData = NasaApiData()
    
    func getPhotos(roverType: RoverType,
                   cameraType: CameraType,
                   date: Date,
                   completionHandler: @escaping (Result<[Photo],Error>) -> Void) {
        var queries: [PhotoQueries] = []
        if let dateString = date.getShortFormString() {
            queries.append(.earthDate(dateString))
        }
        if cameraType != .all {
            queries.append(.camera(cameraType))
        }
        guard
            let url = apiData.roversPhotosURL(roverType: roverType,
                                              photoQueries: queries)
         else {
            return
        }
        print(url)
        let request = AF.request(url, method: .get)
        request.responseDecodable(of: Photos.self) { response in
            do {
                let result = try response.result.get().photos
                completionHandler(.success(result))
            } catch {
                print(error)
                completionHandler(.failure(error))
            }
        }
        
    }
}



