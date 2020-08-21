//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Копаницкий Сергей on 19.08.2020.
//  Copyright © 2020 Копаницкий Сергей. All rights reserved.
//

import Foundation

struct DataToDislpay {
    public let name: String
    public let value: String?
}

enum DisplayedData: Int, CaseIterable  {
    case description
    case currentTemperature
    case minTemperature
    case maxTemperature
    case humidity
    case windSpeed
}

/// Weather view model protocol
protocol WeatherViewModelProtocol {
    var setWeatherData: (() -> Void)? { get set }
    func numberOfRowsInSection() -> Int
    func getCityName() -> String?
    func getCoordinates() -> Coordinate?
    func getData(at index: Int) -> DataToDislpay?
}

/// Weather view model
class WeatherViewModel: WeatherViewModelProtocol {
    
    // MARK: - Class instances
    
    /// Network service instance
    private let networkService: NetworkService
    
    /// Coordinates of the current city
    private let coordinates: Coordinates
    
    /// Passes the received weather data to the weather view controller
    public var setWeatherData: (() -> Void)?
    
    private var weatherData: WeatherModel?
    
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
        guard let urlRequest = URLRequestService.fetchWeather(latitude: coordinates.lat,
                                                              longitude: coordinates.lon).request else { return }
        
        networkService.fetchWatherData(urlRequest: urlRequest) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let weather):
                    self?.weatherData = weather
                    self?.setWeatherData?()
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    public func numberOfRowsInSection() -> Int {
        return DisplayedData.allCases.count
    }
    
    public func getCityName() -> String? {
        return weatherData?.name
    }
    
    public func getCoordinates() -> Coordinate? {
        return weatherData?.coord
    }
    
    public func getData(at index: Int) -> DataToDislpay? {
        
        let dataToDisplay = DisplayedData.init(rawValue: index)
        guard let weatherData = weatherData else { return nil }
        
        switch dataToDisplay {
        case .description:
            return .init(name: "Description:" , value: weatherData.weather.first?.description)
        case .currentTemperature:
            return .init(name: "Current temperature:", value: "\(weatherData.main.temp) ºC")
        case .minTemperature:
            return .init(name: "Min temperature:", value: "\(weatherData.main.temp_min) ºC")
        case .maxTemperature:
            return .init(name: "Max Temperature:", value: "\(weatherData.main.temp_max) ºC")
        case .humidity:
            return .init(name: "Humidity:", value: "\(weatherData.main.humidity) %")
        case .windSpeed:
            return .init(name: "Wind speed:", value: "\(weatherData.wind.speed) km/h")
        default:
            return .init(name: "Unknown:", value: "unknown")
        }
    }
}
