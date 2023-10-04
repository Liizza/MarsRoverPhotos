//
//  RealmModel.swift
//  MarsRoverPhotos
//
//  Created by Liza on 04.10.2023.
//

import Foundation
import RealmSwift

class RealmFiltersModel: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var date: Date
    @Persisted var roverType: String
    @Persisted var cameraType: String
    var roverEnum: RoverType {
        get { return RoverType(rawValue: roverType) ?? .all}
        set { self.roverType = newValue.rawValue }
    }
    var cameraEnum: CameraType {
        get { return CameraType(rawValue: cameraType) ?? .all }
        set { self.cameraType = newValue.rawValue }
    }
}
