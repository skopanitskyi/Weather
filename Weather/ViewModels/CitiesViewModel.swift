//
//  CitiesViewModel.swift
//  Weather
//
//  Created by Копаницкий Сергей on 18.08.2020.
//  Copyright © 2020 Копаницкий Сергей. All rights reserved.
//

import UIKit

/// Cities view model protocol
protocol CitiesViewModelProtocol {
    var updateTableView: (() -> Void)? { get set }
    func getCities()
    func getCityName(at: Int, isFiltering: Bool) -> String
    func numberOfRowsInSection(isFiltering: Bool) -> Int
    func getImage(at index: Int, completion: @escaping ((UIImage) -> Void))
    func getFilteredCities(name: String)
    func pushController(at index: Int, isFiltering: Bool)
}

/// Cities view model
class CitiesViewModel: CitiesViewModelProtocol {
    
    // MARK: - Class instances
    
    /// Stores loaded cities
    private var cities = [CityModel]()
    
    /// Stores sorted cities
    private var filteredCities = [CityModel]()
    
    /// Network service instance
    private let networkService: NetworkService
    
    /// Cities coordinator instance
    private let coordinator: CitiesCoordinator
    
    /// Called when a table view needs to be updated
    public var updateTableView: (() -> Void)?
    
    // MARK: - Class constructor
    
    /// Cities view model class constructor
    /// - Parameters:
    ///   - coordinator: Cities coordinator instance
    ///   - networkService: Network service instance, processes internet requests
    init(coordinator: CitiesCoordinator, networkService: NetworkService) {
        self.coordinator = coordinator
        self.networkService = networkService
    }
    
    // MARK: - Class methods
    
    /// Returns the city name by index. Depending on whether there is a search for cities, selects an array from which data will be taken
    /// - Parameters:
    ///   - index: Index of city in array
    ///   - isFiltering: Is there a search for cities
    public func getCityName(at index: Int, isFiltering: Bool) -> String {
        return isFiltering ? filteredCities[index].name : cities[index].name
    }
    
    /// Returns the number of cities in an array. Depending on whether there is a search for cities, selects an array from which data will be taken
    /// - Parameters:
    ///   - isFiltering: Is there a search for cities
    public func numberOfRowsInSection(isFiltering: Bool) -> Int {
        return isFiltering ? filteredCities.count : cities.count
    }
    
    /// Loads an image for the specified cell by index
    /// - Parameters:
    ///   - index: Index of the cell
    ///   - completion: Returns the loaded image
    public func getImage(at index: Int, completion: @escaping ((UIImage) -> Void)) {
        let isOdd = index % 2 == 1
        guard let urlRequest = URLRequestService.fetchImage(isOdd: isOdd).request else { return }
        
        networkService.downloadImage(urlRequest: urlRequest) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    completion(image)
                case . failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    /// Retrieves city data from the specified file
    public func getCities() {
        
        guard let url = URLRequestService.fetchCities(file: "city.list", type: "json").request?.url else { return }
        
        networkService.fetchCities(from: url) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let cities):
                    self.cities = cities
                    self.updateTableView?()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    /// Filters available cities based on the received name
    /// - Parameters:
    ///   - name: Name of the city are looking for
    public func getFilteredCities(name: String) {
        DispatchQueue.global(qos: .userInteractive).async {
            self.filteredCities = self.cities.filter { $0.name.lowercased().contains(name) }
            DispatchQueue.main.async {
                self.updateTableView?()
            }
        }
    }
    
    /// Displays the weather controller
    /// - Parameters:
    ///   - index: Index of the selected city
    ///   - isFiltering: Is there a search for cities
    public func pushController(at index: Int, isFiltering: Bool) {
        let coordinates = isFiltering ? filteredCities[index].coord : cities[index].coord
        coordinator.showWeatherController(coordinates: coordinates)
    }
}
