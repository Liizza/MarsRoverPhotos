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
    var archiveButtonPressed: PublishSubject<Void> { get }
    var _date: BehaviorRelay<Date> { get }
    func viewModelForDatPickerView() -> DatePickerViewModelProtocol
    func viewModelForCameraPickerView() -> any PickerViewModelProtocol
    func viewModelForRoverPickerView() -> any PickerViewModelProtocol
    func viewModelForSaveFilterView() -> SaveFiltersViewModelProtocol
}

class HomeViewViewModel: HomeViewModelProtocol {
    var archiveButtonPressed = PublishSubject<Void>()
    private let _photos = BehaviorRelay<[Photo]>(value: [])
    var photos: Driver<[Photo]> {
        return _photos.asDriver()
    }
    let networkService: NetworkService?
    let dataService: DataService?
    private let disposeBag = DisposeBag()
    let photoSelected = PublishSubject<IndexPath>()
    private let _dateLabelText = BehaviorRelay<String>(value: "")
    let _date = BehaviorRelay<Date>(value: Date())
    private let _roverType = BehaviorRelay<RoverType>(value: .curiosity)
    
    private let _cameraType = BehaviorRelay<CameraType>(value: .all)
    
    var dateLabelText: Driver<String> {
        return _dateLabelText.asDriver()
    }
    init(networkService: NetworkService?, dataService: DataService?) {
        self.networkService = networkService
        self.dataService = dataService
        bind()
        setDate()
        getPhotos()
    }
    func getPhotos() {
        networkService?.getPhotos(roverType: _roverType.value, cameraType: _cameraType.value, date: _date.value) { [weak self] response in
            switch response {
            case .success(let arrayOfPhotos):
                self?._photos.accept(arrayOfPhotos)
            case .failure(let error):
                print(error)
            }
        }
    }
    func bind() {
        photoSelected.asObservable().subscribe(onNext: { [weak self] indexPath in
            print(self?.photoForIndex(index: indexPath.row)?.rover)
        }).disposed(by: disposeBag)
        archiveButtonPressed.asObservable().subscribe(onNext: { [weak self] in
            print("archive pressed")
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
        stringForDate(date: date)
    }
    private func stringForDate(date: Date) {
        guard let string = date.getFullFormString() else { return }
        _dateLabelText.accept(string)
    }
    func viewModelForDatPickerView() -> DatePickerViewModelProtocol {
        let viewModel = DatePickerViewModel(date: self._date.value)
        viewModel.chooseButtonPressed.asObservable().subscribe(onNext: { [weak self] date in
            guard let self else { return }
            self._date.accept(date)
            stringForDate(date: date)
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
            print("save")
            self?.saveCurrentFilters()
        }).disposed(by: disposeBag)
        return viewModel
    }
    func saveCurrentFilters() {
        dataService?.saveFilters(date: _date.value, roverType: _roverType.value, cameraType: _cameraType.value)
    }
    
}
