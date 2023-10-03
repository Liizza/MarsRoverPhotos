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
    var photos: Driver<[PhotoModel]> { get }
    var calendarButtonPressed: PublishSubject<Void> { get }
    var roverFilterButtonPressed: PublishSubject<Void> { get }
    var cameraFilterButtonPressed: PublishSubject<Void> { get }
    var saveFilterButtonPressed: PublishSubject<Void> { get }
    var photoSelected: PublishSubject<IndexPath> { get }
    var dateLabelText: Driver<String> { get }
    var archiveButtonPressed: PublishSubject<Void> { get }
}

class HomeViewViewModel: HomeViewModelProtocol {
    var archiveButtonPressed = PublishSubject<Void>()
    private let _photos = BehaviorRelay<[PhotoModel]>(value: [])
    var photos: Driver<[PhotoModel]> {
        return _photos.asDriver()
    }
    private let disposeBag = DisposeBag()
    let calendarButtonPressed = PublishSubject<Void>()
    let roverFilterButtonPressed = PublishSubject<Void>()
    let cameraFilterButtonPressed = PublishSubject<Void>()
    let saveFilterButtonPressed = PublishSubject<Void>()
    let photoSelected = PublishSubject<IndexPath>()
    private let _dateLabelText = BehaviorRelay<String>(value: "")
    var dateLabelText: Driver<String> {
        return _dateLabelText.asDriver()
    }
    init() {
        bind()
        getDate()
        getPhotos()
    }
    func getPhotos() {
        
    }
    func getPhotosByCameraType() {
        
    }
    func getPhotoByDate() {
        
    }
    
    func getPhotoByRover() {
        
    }
    func bind() {
        calendarButtonPressed.asObservable().subscribe(onNext: { [weak self] in
            print("calendar button pressed")
        }).disposed(by: disposeBag)
        roverFilterButtonPressed.asObservable().subscribe(onNext: { [weak self] in
            print("rover button pressed")
        }).disposed(by: disposeBag)
        cameraFilterButtonPressed.asObservable().subscribe(onNext: { [weak self] in
            print("camera button pressed")
        }).disposed(by: disposeBag)
        saveFilterButtonPressed.asObservable().subscribe(onNext: { [weak self] in
            print("save filter button pressed")
        }).disposed(by: disposeBag)
        photoSelected.asObservable().subscribe(onNext: { [weak self] indexPath in
            print(self?.photoForIndex(index: indexPath.row)?.rover)
        }).disposed(by: disposeBag)
        archiveButtonPressed.asObservable().subscribe(onNext: { [weak self] in
            print("archive pressed")
        }).disposed(by: disposeBag)
    }
    private func photoForIndex(index: Int) -> PhotoModel? {
        guard index < _photos.value.count else { return nil }
        return _photos.value[index]
    }
    private func getDate() {
        let calendar = Calendar.current
        guard
            let date = calendar.date(byAdding: .day, value: -1, to: calendar.startOfDay(for: Date())),
            let string = date.getFullFormString()
        else { return }
        _dateLabelText.accept(string)
    }
}
