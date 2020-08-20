//
//  WeatherCoordinator.swift
//  Weather
//
//  Created by Копаницкий Сергей on 19.08.2020.
//  Copyright © 2020 Копаницкий Сергей. All rights reserved.
//

import UIKit

/// Weather coordinator displays the weather view controller on the screen
class WeatherCoordinator {
    
    // MARK: - Class instance
    
    /// Navigation controller instance
    private let navigationController: UINavigationController
    
    /// Network service instance
    private let networkService: NetworkService
    
    /// Coordinates of the display city
    private let coordinates: Coordinates
    
    // MARK: - Class constructor
    
    /// Weather coordinator class constructor
    /// - Parameters:
    ///   - navigationController: Root navigation controller which displays the controllers
    ///   - networkService: Network service instance, processes internet requests
    ///   - coordinates: Coordinates of the city to be displayed
    init(navigationController: UINavigationController, networkService: NetworkService, coordinates: Coordinates) {
        self.navigationController = navigationController
        self.networkService = networkService
        self.coordinates = coordinates
    }
    
    // MARK: - Class methods
    
    /// Creates instances of the weather view controller and weather view model classes. Then  displays the weather view controller on the screen
    public func start() {
        let weatherController = WeatherViewController()
        let weatherViewModel = WeatherViewModel(networkService: networkService, coordinates: coordinates)
        weatherController.viewModel = weatherViewModel
        navigationController.pushViewController(weatherController, animated: true)
    }    
}
