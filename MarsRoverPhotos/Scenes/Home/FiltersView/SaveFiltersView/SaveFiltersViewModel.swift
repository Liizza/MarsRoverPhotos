//
//  SaveFiltersViewModel.swift
//  MarsRoverPhotos
//
//  Created by Liza on 04.10.2023.
//

import Foundation
import RxSwift

protocol SaveFiltersViewModelProtocol {
    var title: String { get }
    var description: String { get }
    var didSaveFilters: PublishSubject<Void> { get }
}

class SaveFiltersViewModel: SaveFiltersViewModelProtocol {
    var title: String
    
    var description: String
    
    var didSaveFilters = PublishSubject<Void>()
    
    init() {
        self.title = "Save Filters"
        self.description = "The current filters and the date you have chosen can be saved to the filter history."
    }
}
