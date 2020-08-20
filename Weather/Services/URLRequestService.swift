//
//  UrlRequestService.swift
//  Weather
//
//  Created by Копаницкий Сергей on 20.08.2020.
//  Copyright © 2020 Копаницкий Сергей. All rights reserved.
//

import Foundation

/// Url request service creates requests to get any data
enum URLRequestService {
    
    // MARK: - Request cases

    case fetchCities(file: String, type: String)
    case fetchImage(isOdd: Bool)
    case fetchWeather(latitude: Double, longitude: Double)
    
    // MARK: Instances
    
    /// Creates a request based on the data being loaded
    public var request: URLRequest? {
        let request: URLRequest?
        
        switch self {
            
        case .fetchCities:
            guard let path = path else { return nil }
            let url = URL(fileURLWithPath: path)
            request = URLRequest(url: url)
            
        case .fetchImage:
            guard let path = path, let baseUrl = baseUrl else {
                return nil
            }
            var components = URLComponents(string: baseUrl)
            components?.path = path
            guard let url = components?.url else { return nil }
            request = URLRequest(url: url)
            
        case .fetchWeather:
            guard let path = path, let baseUrl = baseUrl else {
                return nil
            }
            var components = URLComponents(string: baseUrl)
            components?.path = path
            components?.queryItems = queryComponents
            guard let url = components?.url else { return nil }
            request = URLRequest(url: url)
        }
        return request
    }
    
    /// Create base url
    private var baseUrl: String? {
        
        switch self {
        case .fetchCities:
            return nil
        case .fetchImage:
            return "https://infotech.gov.ua"
        case .fetchWeather:
            return "http://api.openweathermap.org"
        }
    }
    
    /// Create path to get data
    private var path: String? {
        
        switch self {
        case .fetchCities(let file, let type):
            return Bundle.main.path(forResource: file, ofType: type)
        case .fetchImage(let isOdd):
            let image = isOdd ? "Temp1.png" : "Temp3.png"
            return "/storage/img/\(image)"
        case .fetchWeather:
            return "/data/2.5/weather"
        }
    }
    
    /// Stores parameters keys for weather request
    private struct ParametersKeys {
        public static let latitude = "lat"
        public static let longitude = "lon"
        public static let units = "units"
        public static let apiKey = "appid"
    }
    
    /// Stores default values for weather request
    private struct DefaultValues {
        public static let units = "metric"
        public static let apiKey = "7049524aabdc1b4822580782646fd690"
    }
    
    /// Create parameters for query components
    private var parameters: [String: Any]? {
        switch self {
        case .fetchWeather(let latitude, let longitude):
            let parameters: [String: Any] = [
                ParametersKeys.latitude : latitude,
                ParametersKeys.longitude : longitude,
                ParametersKeys.units : DefaultValues.units,
                ParametersKeys.apiKey : DefaultValues.apiKey
            ]
            
            return parameters
        default:
            return nil
        }
    }
    
    /// Create query components
    private var queryComponents: [URLQueryItem] {
        var components = [URLQueryItem]()
        
        if let parameters = parameters {
            for parameter in parameters {
                components.append(URLQueryItem(name: parameter.key, value: "\(parameter.value)"))
            }
        }
        return components
    }
}
