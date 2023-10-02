//
//  NetworkService.swift
//  MarsRoverPhotos
//
//  Created by Liza on 28.09.2023.
//

import Foundation
import Alamofire

protocol NetworkService {
    
    func getPhotos(roverType: RoverType?,
                   cameraType: CameraType?,
                   date: String?,
                   completionHandler: @escaping (Result<[Photo],Error>) -> Void)
}

class AlamofireNetworkService: NetworkService {
    var apiData: ApiData = NasaApiData()
    
    func getPhotos(roverType: RoverType?,
                   cameraType: CameraType?,
                   date: String?,
                   completionHandler: @escaping (Result<[Photo],Error>) -> Void) {
        var queries: [PhotoQueries] = [.camera(cameraType ?? .all)]
        if let date {
            queries.append(.earthDate(date))
        }
        guard
            let url = apiData.roversPhotosURL(roverType: roverType ?? .curiosity,
                                              photoQueries: queries)
         else {
            return
        }
        let request = AF.request(url, method: .get)
        request.responseDecodable(of: [Photo].self) { response in
            do {
                let result = try response.result.get()
                completionHandler(.success(result))
            } catch {
                print(error)
                completionHandler(.failure(error))
            }
        }
        
    }
}



