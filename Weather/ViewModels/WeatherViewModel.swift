//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Копаницкий Сергей on 19.08.2020.
//  Copyright © 2020 Копаницкий Сергей. All rights reserved.
//

import Foundation

protocol WeatherViewModelProtocol {
    var data: ((WeatherModel) -> Void)? { get set }
}

class WeatherViewModel: WeatherViewModelProtocol {
    
    private let networkService: NetworkService
    
    private let coordinates: Coordinates
    
    public var data: ((WeatherModel) -> Void)?
    
    init(networkService: NetworkService, coordinates: Coordinates) {
        self.networkService = networkService
        self.coordinates = coordinates
        downloadWeatherData()
    }
    
    private func downloadWeatherData() {
        NetworkService().fetchWatherData(lat: coordinates.lat, lon: coordinates.lon) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let weather):
                    self?.data?(weather)
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
