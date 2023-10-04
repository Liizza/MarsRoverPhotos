//
//  AppCoordinator.swift
//  MarsRoverPhotos
//
//  Created by Liza on 28.09.2023.
//

import UIKit

class AppCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var window: UIWindow?
    let networkService = AlamofireNetworkService()
    let dataService = RealmDataService()
    init(window: UIWindow?) {
        self.window = window
    }
    func start() {
        openHomeVC()
    }
    func openHomeVC() {
        window?.rootViewController = nil
        let navController = UINavigationController()
        let child = HomeCoordinator(navigationController: navController, networkService: networkService, dataService: dataService)
        self.addChildCoordinator(child)
        child.start()
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
    
    
    func finish() {
        
    }
    
    
}
