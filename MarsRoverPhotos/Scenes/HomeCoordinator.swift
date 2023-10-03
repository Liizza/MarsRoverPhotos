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
    init(navigationController: UINavigationController, networkService: NetworkService?) {
        self.navigationController = navigationController
        self.networkService = networkService
    }
    
    func start() {
        let homeVC = HomeViewController.instantiate()
        homeVC.viewModel = HomeViewViewModel(networkService: networkService)
        navigationController.pushViewController(homeVC, animated: false)
    }
    
    func finish() {
    
    }
    
}
