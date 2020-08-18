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
    func getFilteredCities(name: String) -> [CityModel]
}

class CitiesViewModel: CitiesViewModelProtocol {
    
    private var cities = [CityModel]()
        
    public func getCityName(at index: Int) -> String {
        return cities[index].name
    }
    
    public func numberOfRowsInSection() -> Int {
        return cities.count
    }
    
    public func getImage(image: Downloaded, completion: @escaping ((UIImage) -> Void)) {
        NetworkService().downloadImage(image: image) { result in
            switch result {
            case .success(let image):
                completion(image)
            case . failure(let error):
                print(error.localizedDescription)
            }
        }
}
    public func getCities(completion: () -> Void) {
        NetworkService().getCities(from: "city.list") { result in
            switch result {
            case .success(let cities):
                self.cities = cities
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    public func getFilteredCities(name: String) -> [CityModel] {
        return cities.filter { $0.name.contains(name) }
    }
}
