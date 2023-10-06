//
//  HomeViewViewModel.swift
//  MarsRoverPhotos
//
//  Created by Liza on 03.10.2023.
//

import Foundation
import RxSwift
import RxCocoa

protocol HomeViewModelProtocol {
    var photos: Driver<[Photo]> { get }
    var photoSelected: PublishSubject<IndexPath> { get }
    var dateLabelText: Driver<String> { get }
    var openHistoryVC: PublishSubject<Void> { get }
    var openPhotoVC: PublishSubject<String> { get }
    var isLoading: BehaviorSubject<Bool> { get }
    var isNoData: Driver<(Bool, String)> { get }
    func viewModelForDatPickerView() -> DatePickerViewModelProtocol
    func viewModelForCameraPickerView() -> any PickerViewModelProtocol
    func viewModelForRoverPickerView() -> any PickerViewModelProtocol
    func viewModelForSaveFilterView() -> SaveFiltersViewModelProtocol
}

class HomeViewViewModel: HomeViewModelProtocol {
    var openHistoryVC = PublishSubject<Void>()
    var openPhotoVC = PublishSubject<String>()
    
    private let _photos = BehaviorRelay<[Photo]>(value: [])
    var photos: Driver<[Photo]> {
        return _photos.asDriver()
    }
    
    let isLoading = BehaviorSubject<Bool>(value: true)
    
    private let _isNoData = BehaviorRelay<(Bool, String)>(value: (false, ""))
    var isNoData: Driver<(Bool, String)> {
        return  _isNoData.asDriver()
    }
    
    private let networkService: NetworkService?
    private let dataService: DataService?
    private let disposeBag = DisposeBag()
    
    let photoSelected = PublishSubject<IndexPath>()
    private let _date = BehaviorRelay<Date>(value: Date())
    private let _roverType = BehaviorRelay<RoverType>(value: .curiosity)
    private let _cameraType = BehaviorRelay<CameraType>(value: .all)
    
    var dateLabelText: Driver<String> {
        _date.map({$0.getFullFormString() ?? "" }).asDriver(onErrorJustReturn: "")
    }
    init(networkService: NetworkService?, dataService: DataService?) {
        self.networkService = networkService
        self.dataService = dataService
        bind()
        setDate()
        getPhotos { [weak self] in
            self?.isLoading.onNext(false)
        }
    }
    func getPhotos(complection: @escaping (() -> ()) = {}) {
        networkService?.getPhotos(roverType: _roverType.value, cameraType: _cameraType.value, date: _date.value) { [weak self] response in
            guard let self else { return }
            switch response {
            case .success(let arrayOfPhotos):
                self._photos.accept(arrayOfPhotos)
                self._photos.value.isEmpty ? self._isNoData.accept((true, self.currentFiltersString())) : self._isNoData.accept((false, self.currentFiltersString()))
                complection()
            case .failure(let error):
                print(error)
            }
        }
    }
    func bind() {
        photoSelected.asObservable().subscribe(onNext: { [weak self] indexPath in
            guard let image = self?.photoForIndex(index: indexPath.item)?.imgSrc else { return }
            self?.openPhotoVC.asObserver().onNext(image)
        }).disposed(by: disposeBag)
    }
    private func photoForIndex(index: Int) -> Photo? {
        guard index < _photos.value.count else { return nil }
        return _photos.value[index]
    }
    func setDate() {
        let calendar = Calendar.current
        guard
            let date = calendar.date(byAdding: .day, value: -2, to: calendar.startOfDay(for: Date()))
        else { return }
        _date.accept(date)
    }
    func viewModelForDatPickerView() -> DatePickerViewModelProtocol {
        let viewModel = DatePickerViewModel(date: self._date.value)
        viewModel.chooseButtonPressed.asObservable().subscribe(onNext: { [weak self] date in
            guard let self else { return }
            self._date.accept(date)
            self.getPhotos()
        }).disposed(by: disposeBag)
        return viewModel
    }
    func viewModelForCameraPickerView() -> any PickerViewModelProtocol {
        let viewModel = CameraPickerViewModel(arrayOfItems: CameraType.allCases)
        viewModel.didChooseFilter.asObservable().subscribe(onNext: { [weak self] camera in
            guard let self else { return }
            self._cameraType.accept(camera)
            self.getPhotos()
        }).disposed(by: disposeBag)
        return viewModel
    }
    func viewModelForRoverPickerView() -> any PickerViewModelProtocol {
        let viewModel = RoverPickerViewModel(arrayOfItems: RoverType.allCases)
        viewModel.didChooseFilter.asObservable().subscribe(onNext: { [weak self] rover in
            guard let self else { return }
            self._roverType.accept(rover)
            self.getPhotos()
        }).disposed(by: disposeBag)
        return viewModel
    }
    func viewModelForSaveFilterView() -> SaveFiltersViewModelProtocol {
        let viewModel = SaveFiltersViewModel()
        viewModel.didSaveFilters.asObservable().subscribe(onNext: { [weak self] in
            self?.saveCurrentFilters()
        }).disposed(by: disposeBag)
        return viewModel
    }
    func saveCurrentFilters() {
        dataService?.saveFilters(date: _date.value, roverType: _roverType.value, cameraType: _cameraType.value)
    }
    func setFilters(date: Date, roverType: RoverType, cameraType: CameraType) {
        self._date.accept(date)
        self._cameraType.accept(cameraType)
        self._roverType.accept(roverType)
        getPhotos()
    }
    func currentFiltersString() -> String {
        let stringPresentation = "rover: \(_roverType.value.fullName), camera: \(_cameraType.value.fullName), date: \(_date.value.getFullFormString() ?? "")"
        return stringPresentation
    }
    
}
