//
//  AppCoordinator.swift
//  Weather
//
//  Created by Копаницкий Сергей on 19.08.2020.
//  Copyright © 2020 Копаницкий Сергей. All rights reserved.
//

import UIKit

class AppCoordinator {
    
    private let window: UIWindow
        
    private let networkService: NetworkService = NetworkService()
    
    private let navigationController = UINavigationController()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    public func start() {
        let citiesCoordinator = CitiesCoordinator(navigationController: navigationController, networkService: networkService)
        citiesCoordinator.start()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
