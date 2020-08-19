//
//  NetworkService.swift
//  Weather
//
//  Created by Копаницкий Сергей on 18.08.2020.
//  Copyright © 2020 Копаницкий Сергей. All rights reserved.
//

import UIKit

enum Downloaded: String {
    case temp1 = "https://infotech.gov.ua/storage/img/Temp1.png"
    case temp2 = "https://infotech.gov.ua/storage/img/Temp3.png"
}

// api.openweathermap.org/data/2.5/weather?lat=51.50853&lon=-0.12574&units=metric&appid=7049524aabdc1b4822580782646fd690

class NetworkService {
    
    private let diskCapacitySize = 50 * 1024 * 1024
    
    private lazy var cache: URLCache = {
        return URLCache(memoryCapacity: 0, diskCapacity: diskCapacitySize, diskPath: "images")
    }()
    
    private func urlSession() -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        configuration.urlCache = cache
        return URLSession(configuration: configuration)
    }
    
    
    public func downloadImage(image: Downloaded, completion: @escaping (Result<UIImage, Error>) -> Void) {
        
        if let cache = cache.cachedResponse(for: URLRequest(url: URL(string: image.rawValue)!)) {
            guard let image = UIImage(data: cache.data) else { return }
            completion(.success(image))
        } else {
            urlSession().dataTask(with: URL(string: image.rawValue)!) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                if let image = UIImage(data: data!) {
                    completion(.success(image))
                }
            }.resume()
        }
    }
    
    public func fetchWatherData(lat: Double, lon: Double, completion: @escaping (Result<WeatherModel, Error>) -> Void) {
        URLSession.shared.dataTask(with: URL(string: "http://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&units=metric&appid=7049524aabdc1b4822580782646fd690")!) { (data, response, error) in
            
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
    
    public func getCities(from file: String, completion: (Result<[CityModel], Error>) -> Void) {
        let path = Bundle.main.path(forResource: file, ofType: "json")!
        let url = URL(fileURLWithPath: path)
        let jsonData = try! Data(contentsOf: url)
        let users = try! JSONDecoder().decode([CityModel].self, from: jsonData)
        completion(.success(users))
    }
}
