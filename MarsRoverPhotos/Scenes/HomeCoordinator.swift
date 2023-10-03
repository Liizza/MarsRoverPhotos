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
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let homeVC = HomeViewController.instantiate()
        homeVC.viewModel = HomeViewViewModel()
        navigationController.pushViewController(homeVC, animated: false)
    }
    
    func finish() {
    
    }
    
}
