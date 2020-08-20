//
//  NetworkService.swift
//  Weather
//
//  Created by Копаницкий Сергей on 18.08.2020.
//  Copyright © 2020 Копаницкий Сергей. All rights reserved.
//

import UIKit

/// Network service provides methods for downloading data from the network as well as internal files
class NetworkService {
    
    // MARK: - Class instance
    
    /// The size in megabytes that will be allocated for cached data
    private let diskCapacitySize = 50 * 1024 * 1024
    
    /// Creates an instance of the url cache class
    private lazy var cache: URLCache = {
        return URLCache(memoryCapacity: 0, diskCapacity: diskCapacitySize, diskPath: "images")
    }()
    
    // MARK: - Class methods
    
    /// Creates url  session and configures it
    private func urlSession() -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        configuration.urlCache = cache
        return URLSession(configuration: configuration)
    }
    
    /// Downloads an image at the specified request and caches it. If the image for this request is already cached, it requests it from the internal storage.
    /// - Parameters:
    ///   - urlRequest: The request by which the image will be received
    ///   - completion: Returns uploaded image or error
    public func downloadImage(urlRequest: URLRequest, completion: @escaping (Result<UIImage, Error>) -> Void) {
        
        if let cache = cache.cachedResponse(for: urlRequest) {
            guard let image = UIImage(data: cache.data) else { return }
            completion(.success(image))
        } else {
            urlSession().dataTask(with: urlRequest) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                if let data = data, let image = UIImage(data: data) {
                    completion(.success(image))
                }
            }.resume()
        }
    }
    
    /// Downloads weather data for the specified request
    /// - Parameters:
    ///   - urlRequest: The request for which weather data will be received
    ///   - completion: Returns uploaded data or error
    public func fetchWatherData(urlRequest: URLRequest, completion: @escaping (Result<WeatherModel, Error>) -> Void) {
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data {
                do {
                    let weather = try JSONDecoder().decode(WeatherModel.self, from: data)
                    completion(.success(weather))
                } catch (let error) {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    /// Gets city data from an internal file. Data is loaded in a background thread to avoid slowing down the loading of the application
    /// - Parameters:
    ///   - url: The url for which cities data will be received
    ///   - completion: Returns uploaded data or error
    public func fetchCities(from url: URL, completion: @escaping (Result<[CityModel], Error>) -> Void) {
        DispatchQueue.global(qos: .userInteractive).async {
            do {
                let jsonData = try Data(contentsOf: url)
                let users = try JSONDecoder().decode([CityModel].self, from: jsonData)
                completion(.success(users))
            } catch(let error) {
                completion(.failure(error))
            }
        }
    }
}
