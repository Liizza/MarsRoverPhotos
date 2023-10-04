//
//  HistoryViewViewModel.swift
//  MarsRoverPhotos
//
//  Created by Liza on 04.10.2023.
//

import Foundation
import RxSwift
import RxCocoa

protocol HistoryViewModelProtocol {
    var items: Driver<[RealmFiltersModel]> { get }
    var itemDeleted: PublishSubject<IndexPath> { get }
    var itemSelected: PublishSubject<IndexPath> { get }
    var didFiltersSelected: PublishSubject<RealmFiltersModel> { get }
    var isNotEmpty: Driver<Bool> { get }
}

class HistoryViewViewModel: HistoryViewModelProtocol {
    private let disposeBag = DisposeBag()
    private let _isNotEmpty = BehaviorRelay<Bool>(value: false)
    var isNotEmpty: Driver<Bool> {
        return  _isNotEmpty.asDriver()
    }
    private let _items = BehaviorRelay<[RealmFiltersModel]>(value: [])
    var didFiltersSelected = PublishSubject<RealmFiltersModel>()
    let itemDeleted = PublishSubject<IndexPath>()
    let itemSelected = PublishSubject<IndexPath>()
    var items: Driver<[RealmFiltersModel]> {
        return _items.asDriver()
    }
    private let dataService: DataService?
    init(dataService: DataService?) {
        self.dataService = dataService
        getData()
        bind()
    }
    func bind() {
        itemDeleted.asObservable().subscribe(onNext: { [ weak self] indexPath in
            guard let item = self?.itemForIndex(index: indexPath.item) else { return }
            self?.deleteItem(id: item.id)
        }).disposed(by: disposeBag)
        itemSelected.asObservable().subscribe(onNext: { [ weak self] indexPath in
            guard let item = self?.itemForIndex(index: indexPath.row) else { return }
            self?.didFiltersSelected.asObserver().onNext(item)
        }).disposed(by: disposeBag)
    }
    func getData() {
        guard let filters = dataService?.getListOfFilters() else { return }
        _items.accept(filters)
        _items.value.isEmpty ? _isNotEmpty.accept(false) : _isNotEmpty.accept(true)
    }
    func deleteItem(id: String) {
        dataService?.deleteFilters(id: id) { [weak self] in
            self?.getData()
        }
    }
    private func itemForIndex(index: Int) -> RealmFiltersModel? {
        guard index < _items.value.count else { return nil }
        return _items.value[index]
    }
}
