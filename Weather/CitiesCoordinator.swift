//
//  CitiesCoordinator.swift
//  Weather
//
//  Created by Копаницкий Сергей on 19.08.2020.
//  Copyright © 2020 Копаницкий Сергей. All rights reserved.
//

import UIKit

class CitiesCoordinator {
        
    private let networkService: NetworkService
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController, networkService: NetworkService) {
        self.navigationController = navigationController
        self.networkService = networkService
    }
    
    public func start() {
        let citiesController = CitiesViewController()
        let citiesViewModel = CitiesViewModel(coordinator: self, networkService: networkService)
        citiesController.viewModel = citiesViewModel
        navigationController.pushViewController(citiesController, animated: true)
    }
    
    public func showWeatherController(coordinates: Coordinates) {
        let weatherCoordinator = WeatherCoordinator(navigationController: navigationController,
                                                    networkService: networkService,
                                                    coordinates: coordinates)
        weatherCoordinator.start()
    }
}
