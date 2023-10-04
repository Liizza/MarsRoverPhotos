//
//  RoverPickerViewModel.swift
//  MarsRoverPhotos
//
//  Created by Liza on 04.10.2023.
//

import Foundation
import RxSwift
import RxCocoa

class RoverPickerViewModel: PickerViewModelProtocol {
    private let disposeBag = DisposeBag()
    private let _items = BehaviorRelay<[String]>(value: [])
    private var arrayOfItems: [RoverType]
    let chooseButtonPressed = PublishSubject<Void>()
    
    let itemSelected = PublishSubject<Int>()
    private let currentItem = BehaviorRelay<RoverType>(value: .all)
    let didChooseFilter = PublishSubject<RoverType>()
    
    var items: Driver<[String]> {
        _items.asDriver()
    }
    required init(arrayOfItems: [RoverType]) {
        self.arrayOfItems = arrayOfItems
        _items.accept(arrayOfItems.map({$0.fullName}))
        bind()
    }
    func bind() {
        itemSelected.asObservable().subscribe(onNext: { [weak self] index in
            guard let self else { return }
            self.currentItem.accept(self.arrayOfItems[index])
        }).disposed(by: disposeBag)
        chooseButtonPressed.asObservable().subscribe(onNext: { [weak self] in
            guard let self else { return }
            self.didChooseFilter.asObserver().onNext(self.currentItem.value)
        }).disposed(by: disposeBag)
    }
}
