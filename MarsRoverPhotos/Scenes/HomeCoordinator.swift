//
//  HomeCoordinator.swift
//  MarsRoverPhotos
//
//  Created by Liza on 28.09.2023.
//

import UIKit

class HomeCoordinator: Coordinator {
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
        homeVC.viewModel = HomeViewViewModel(networkService: networkService, dataService: dataService)
        navigationController.pushViewController(homeVC, animated: false)
    }
    
    func finish() {
    
    }
    
}
