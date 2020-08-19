//
//  CitiesViewModel.swift
//  Weather
//
//  Created by Копаницкий Сергей on 18.08.2020.
//  Copyright © 2020 Копаницкий Сергей. All rights reserved.
//

import UIKit

protocol CitiesViewModelProtocol {
    func getCities(completion: () -> Void)
    func getCityName(at: Int) -> String
    func numberOfRowsInSection() -> Int
    func getImage(image: Downloaded, completion: @escaping ((UIImage) -> Void))
    func getFilteredCities(name: String, completion: @escaping ([CityModel]) -> Void)
    func pushController(at index: Int)
}

class CitiesViewModel: CitiesViewModelProtocol {
    
    private var cities = [CityModel]()
    
    private var filteredCities = [CityModel]()

    private let networkService: NetworkService
    
    private let coordinator: CitiesCoordinator
    
    init(coordinator: CitiesCoordinator, networkService: NetworkService) {
        self.coordinator = coordinator
        self.networkService = networkService
    }
            
    public func getCityName(at index: Int) -> String {
        return cities[index].name
    }
    
    public func numberOfRowsInSection() -> Int {
        return cities.count
    }
    
    public func getImage(image: Downloaded, completion: @escaping ((UIImage) -> Void)) {
        networkService.downloadImage(image: image) { result in
            switch result {
            case .success(let image):
                completion(image)
            case . failure(let error):
                print(error.localizedDescription)
            }
        }
}
    public func getCities(completion: () -> Void) {
        networkService.getCities(from: "city.list") { result in
            switch result {
            case .success(let cities):
                self.cities = cities
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    public func getFilteredCities(name: String, completion: @escaping ([CityModel]) -> Void) {
        DispatchQueue.global(qos: .userInteractive).async {
            let filteredCities = self.cities.filter { $0.name.contains(name) }
            completion(filteredCities)
        }
    }
    
    public func pushController(at index: Int) {
        let coordinates = cities[index].coord
        coordinator.showWeatherController(coordinates: coordinates)
    }
}
