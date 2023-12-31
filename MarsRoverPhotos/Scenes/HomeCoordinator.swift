//
//  HomeCoordinator.swift
//  MarsRoverPhotos
//
//  Created by Liza on 28.09.2023.
//

import UIKit
import RxSwift
class HomeCoordinator: Coordinator {
    private let disposeBag = DisposeBag()
    var setNewFilters = PublishSubject<FiltersModel>()
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    let networkService: NetworkService?
    let dataService: DataService?
    init(navigationController: UINavigationController, networkService: NetworkService?, dataService: DataService?) {
        self.navigationController = navigationController
        self.networkService = networkService
        self.dataService = dataService
    }
    
    func start() {
        let homeVC = HomeViewController.instantiate()
        let viewModel = HomeViewViewModel(networkService: networkService, dataService: dataService)
        homeVC.viewModel = viewModel
        viewModel.openHistoryVC.asObservable().subscribe(onNext: { [weak self] in
            self?.openHistoryViewController()
        }).disposed(by: disposeBag)
        viewModel.openPhotoVC.asObservable().subscribe(onNext: { [weak self] imageSrc in
            self?.openPhotoVC(with: imageSrc)
        }).disposed(by: disposeBag)
        setNewFilters.asObservable().subscribe(onNext: { filter in
            viewModel.setFilters(date: filter.date, roverType: filter.roverEnum, cameraType: filter.cameraEnum)
        }).disposed(by: disposeBag)
        viewModel.isLoading.asObservable().subscribe(onNext: { [weak self] isLoading in
            if isLoading {
                self?.openPreloaderVC()
            } else {
                self?.navigationController.setViewControllers([homeVC], animated: true)
            }
        }).disposed(by: disposeBag)
    }
    func openHistoryViewController() {
        let historyVC = HistoryViewController.instantiate()
        let viewModel = HistoryViewViewModel(dataService: dataService)
        viewModel.didFiltersSelected.asObservable().subscribe(onNext:  { [weak self] filters in
            self?.setNewFilters.asObserver().onNext(filters)
            self?.navigationController.popViewController(animated: false)
        }).disposed(by: disposeBag)
        historyVC.viewModel = viewModel
        navigationController.pushViewController(historyVC, animated: true)
    }
    func openPhotoVC(with imageSrc: String) {
        let photoVC = PhotoViewController.instantiate()
        photoVC.viewModel = PhotoViewViewModel(imageName: imageSrc)
        navigationController.pushViewController(photoVC, animated: true)
    }
    func openPreloaderVC() {
        let preloaderVC = PreloaderViewController()
        navigationController.pushViewController(preloaderVC, animated: false)
    }
    
    func finish() {
    
    }
    
}
