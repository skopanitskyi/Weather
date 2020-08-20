//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Копаницкий Сергей on 19.08.2020.
//  Copyright © 2020 Копаницкий Сергей. All rights reserved.
//

import Foundation

/// Weather view model protocol
protocol WeatherViewModelProtocol {
    var setWeatherData: ((WeatherModel) -> Void)? { get set }
}

/// Weather view model
class WeatherViewModel: WeatherViewModelProtocol {
    
    // MARK: - Class instances
    
    /// Network service instance
    private let networkService: NetworkService
    
    /// Coordinates of the current city
    private let coordinates: Coordinates
    
    /// Passes the received weather data to the weather view controller
    public var setWeatherData: ((WeatherModel) -> Void)?
    
    // MARK: - Class constructor
    
    /// Weather view model class constructor
    /// - Parameters:
    ///   - networkService: Network service instance, processes internet requests
    ///   - coordinates: Coordinates of the selected city
    init(networkService: NetworkService, coordinates: Coordinates) {
        self.networkService = networkService
        self.coordinates = coordinates
        downloadWeatherData()
    }
    
    // MARK: - Class methods
    
    /// Requests weather data for the displayed city
    private func downloadWeatherData() {
        
        guard let urlRequest = URLRequestService.fetchWeather(latitude: coordinates.lat, longitude: coordinates.lon).request else { return }
        
        networkService.fetchWatherData(urlRequest: urlRequest) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let weather):
                    self?.setWeatherData?(weather)
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
