//
//  AppCoordinator.swift
//  Weather
//
//  Created by Копаницкий Сергей on 19.08.2020.
//  Copyright © 2020 Копаницкий Сергей. All rights reserved.
//

import UIKit

/// Main application coordinator. Controls display of controllers.
class AppCoordinator {
    
    // MARK: - Class instance
    
    /// Window instance
    private let window: UIWindow
        
    /// Network service instance
    private let networkService: NetworkService = NetworkService()
    
    /// Navigation controller instance
    private let navigationController = UINavigationController()
    
    // MARK: - Class constructor
    
    /// App coordinator class constructor
    /// - Parameter window: Window instance of the application
    init(window: UIWindow) {
        self.window = window
    }
    
    // MARK: - Class methods
    
    /// Creates a cities coordinator, that displays the main controller of the application - Cities View Controller
    public func start() {
        let citiesCoordinator = CitiesCoordinator(navigationController: navigationController, networkService: networkService)
        citiesCoordinator.start()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
