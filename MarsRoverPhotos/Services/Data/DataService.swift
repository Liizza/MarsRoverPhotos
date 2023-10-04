//
//  DataService.swift
//  MarsRoverPhotos
//
//  Created by Liza on 04.10.2023.
//

import Foundation
import RealmSwift

protocol DataService {
    func saveFilters(date: Date, roverType: RoverType, cameraType: CameraType)
    func deleteFilters(id: String, completion: @escaping() -> Void)
    func getListOfFilters() -> [RealmFiltersModel]?
}
class RealmDataService: DataService {
    let realm = try? Realm()
    init() {
        
    }
    func saveFilters(date: Date, roverType: RoverType, cameraType: CameraType) {
        guard let realm else { return }
        let id = UUID().uuidString
        let filterModel = RealmFiltersModel()
        filterModel.id = id
        filterModel.date = date
        filterModel.cameraEnum = cameraType
        filterModel.roverEnum = roverType
        try? realm.write {
            realm.add(filterModel, update: .all)
        }
    }
    func deleteFilters(id: String, completion: @escaping() -> Void) {
        guard let realm else { return }
        guard let object = realm.object(ofType: RealmFiltersModel.self, forPrimaryKey: id) else { return }
        try? realm.write {
            realm.delete(object)
            completion()
        }
    }
    func getListOfFilters() -> [RealmFiltersModel]? {
        guard let realm  else { return nil }
        let results = Array(realm.objects(RealmFiltersModel.self))
        return results
    }
}
