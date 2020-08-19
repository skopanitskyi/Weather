//
//  WeatherCoordinator.swift
//  Weather
//
//  Created by Копаницкий Сергей on 19.08.2020.
//  Copyright © 2020 Копаницкий Сергей. All rights reserved.
//

import UIKit

class WeatherCoordinator {
    
    private let navigationController: UINavigationController
    
    private let networkService: NetworkService
    
    private let coordinates: Coordinates
    
    init(navigationController: UINavigationController, networkService: NetworkService, coordinates: Coordinates) {
        self.navigationController = navigationController
        self.networkService = networkService
        self.coordinates = coordinates
    }
    
    public func start() {
        let weatherController = WeatherViewController()
        let weatherViewModel = WeatherViewModel(networkService: networkService, coordinates: coordinates)
        weatherController.viewModel = weatherViewModel
        navigationController.pushViewController(weatherController, animated: true)
    }    
}
