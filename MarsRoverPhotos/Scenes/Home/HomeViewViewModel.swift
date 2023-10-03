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
    var dateChosen: PublishSubject<Date> { get }
    var roverTypeChosen: PublishSubject<RoverType> { get }
    var cameraTypeChosen: PublishSubject<CameraType> { get }
}

class HomeViewViewModel: HomeViewModelProtocol {
    var archiveButtonPressed = PublishSubject<Void>()
    private let _photos = BehaviorRelay<[Photo]>(value: [])
    var photos: Driver<[Photo]> {
        return _photos.asDriver()
    }
    let networkService: NetworkService?
    private let disposeBag = DisposeBag()
    let photoSelected = PublishSubject<IndexPath>()
    private let _dateLabelText = BehaviorRelay<String>(value: "")
    let dateChosen = PublishSubject<Date>()
    private let _date = BehaviorRelay<Date>(value: Date())
    private let _roverType = BehaviorRelay<RoverType>(value: .curiosity)
    let roverTypeChosen = PublishSubject<RoverType>()
    private let _cameraType = BehaviorRelay<CameraType>(value: .all)
    let cameraTypeChosen = PublishSubject<CameraType>()
    var dateLabelText: Driver<String> {
        return _dateLabelText.asDriver()
    }
    init(networkService: NetworkService?) {
        self.networkService = networkService
        bind()
        bindFilterElements()
        setDate()
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
    func bindFilterElements() {
        dateChosen.asObservable().subscribe(onNext: { [weak self] date in
            guard let self else { return }
            self._date.accept(date)
            stringForDate(date: date)
            self.getPhotos()
        }).disposed(by: disposeBag)
        roverTypeChosen.asObservable().subscribe(onNext: { [weak self] roverType in
            guard let self else { return }
            self._roverType.accept(roverType)
            self.getPhotos()
        }).disposed(by: disposeBag)
        cameraTypeChosen.asObservable().subscribe(onNext: { [weak self] cameraType in
            guard let self else { return }
            self._cameraType.accept(cameraType)
            self.getPhotos()
        }).disposed(by: disposeBag)
    }
    private func photoForIndex(index: Int) -> Photo? {
        guard index < _photos.value.count else { return nil }
        return _photos.value[index]
    }
    func setDate() {
        let calendar = Calendar.current
        let date = calendar.date(byAdding: .day, value: -1, to: calendar.startOfDay(for: Date()))
        dateChosen.asObserver().onNext(date ?? Date())
    }
    private func stringForDate(date: Date) {
        guard let string = date.getFullFormString() else { return }
        _dateLabelText.accept(string)
    }
}
