//
//  PickerViewViewModel.swift
//  MarsRoverPhotos
//
//  Created by Liza on 04.10.2023.
//

import Foundation
import RxSwift
import RxCocoa

protocol PickerViewModelProtocol {
    associatedtype ItemType
    var items: Driver<[String]> { get }
    var chooseButtonPressed: PublishSubject<Void> { get }
    var itemSelected: PublishSubject<Int> { get }
    var didChooseFilter: PublishSubject<ItemType> { get }
    init(arrayOfItems: [ItemType])
    
}

class CameraPickerViewModel: PickerViewModelProtocol {
    private let disposeBag = DisposeBag()
    private let _items = BehaviorRelay<[String]>(value: [])
    private var arrayOfItems: [CameraType]
    let chooseButtonPressed = PublishSubject<Void>()
    
    let itemSelected = PublishSubject<Int>()
    private let currentItem = BehaviorRelay<CameraType>(value: .all)
    let didChooseFilter = PublishSubject<CameraType>()
    
    var items: Driver<[String]> {
        _items.asDriver()
    }
    required init(arrayOfItems: [CameraType]) {
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
