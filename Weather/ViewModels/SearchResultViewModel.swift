//
//  SearchResultViewModel.swift
//  Weather
//
//  Created by Копаницкий Сергей on 18.08.2020.
//  Copyright © 2020 Копаницкий Сергей. All rights reserved.
//

import Foundation

protocol SearchResultViewModelProtocol {
    var updateTableView: (() -> Void)? { get set }
    func numberOfRowsInSection() -> Int
    func getCityName(at index: Int) -> String
    func setFilteredCities(cities: [CityModel])
}

class SearchResultViewModel: SearchResultViewModelProtocol {
    
    private var filteredCities = [CityModel]()
    
    public var updateTableView: (() -> Void)?
    
    public func numberOfRowsInSection() -> Int {
        return filteredCities.count
    }
    
    public func getCityName(at index: Int) -> String {
        let city = filteredCities[index]
        return "\(city.name) (\(city.country))"
    }
    
    public func setFilteredCities(cities: [CityModel]) {
        filteredCities = cities
        updateTableView?()
    }
}
