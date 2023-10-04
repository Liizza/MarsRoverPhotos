//
//  DatePickerViewModel.swift
//  MarsRoverPhotos
//
//  Created by Liza on 04.10.2023.
//

import Foundation
import RxSwift
protocol DatePickerViewModelProtocol {
    var date: Date { get }
    init(date: Date)
    //var cancelButtonPressed: PublishSubject<Void> { get }
    var chooseButtonPressed: PublishSubject<Date> { get }
}

class DatePickerViewModel: DatePickerViewModelProtocol {
    
    var date: Date
    //var cancelButtonPressed = PublishSubject<Void>()
    var chooseButtonPressed = PublishSubject<Date>()
    
    required init(date: Date) {
        self.date = date
    }
    
    
}
