//
//  CitiesCoordinator.swift
//  Weather
//
//  Created by Копаницкий Сергей on 19.08.2020.
//  Copyright © 2020 Копаницкий Сергей. All rights reserved.
//

import UIKit

/// Cities coordinator displays the cities view controller by the main controller and also creates a weather coordinator
class CitiesCoordinator {
    
    // MARK: - Class instance
        
    /// Network service instance
    private let networkService: NetworkService
    
    /// Navigation controller instance
    private let navigationController: UINavigationController
    
    // MARK: - Class constructor
    
    /// Cities coordinator class constructor
    /// - Parameters:
    ///   - navigationController: Root navigation controller which displays the controllers
    ///   - networkService: Network service instance, processes internet requests
    init(navigationController: UINavigationController, networkService: NetworkService) {
        self.navigationController = navigationController
        self.networkService = networkService
    }
    
    // MARK: - Class methods
    
    /// Creates instances of the cities view controller and cities view model classes. Then  displays the cities view controller on the screen
    public func start() {
        let citiesController = CitiesViewController()
        let citiesViewModel = CitiesViewModel(coordinator: self, networkService: networkService)
        citiesController.viewModel = citiesViewModel
        navigationController.pushViewController(citiesController, animated: true)
    }
    
    /// Creates a weather coordinator that displays the weather view controller
    /// - Parameter coordinates: Coordinates of the city that will be display on the map
    public func showWeatherController(coordinates: Coordinates) {
        let weatherCoordinator = WeatherCoordinator(navigationController: navigationController,
                                                    networkService: networkService,
                                                    coordinates: coordinates)
        weatherCoordinator.start()
    }
}
