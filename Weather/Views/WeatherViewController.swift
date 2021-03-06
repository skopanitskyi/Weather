//
//  WeatherViewController.swift
//  Weather
//
//  Created by Копаницкий Сергей on 19.08.2020.
//  Copyright © 2020 Копаницкий Сергей. All rights reserved.
//

import UIKit
import MapKit

/// Weather view controller displays the selected city on the map as well as weather information
class WeatherViewController: UIViewController {
    
    // MARK: - Class instances
    
    /// Number of labels that display information
    private let numberOfLabels: CGFloat = 6
    
    /// Distance in meters from the current location
    private let locationDistance: CLLocationDistance = 50000
    
    /// Weather view model instance
    public var viewModel: WeatherViewModelProtocol?
    
    /// Reuse indentifier for cell
    private let reuseIdentifier = "Cell"
    
    /// Returns the frame for the header view
    private var frame: CGRect {
        return .init(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height / 2)
    }
    
    // MARK: - Create UI elements
    
    /// Create map view
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.mapType = .standard
        return mapView
    }()
    
    /// Create table view
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Class life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
        setupTableHeaderView()
        displayWeatherData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let header = tableView.tableHeaderView as? TableHeaderView else { return }
        header.frame = frame
    }
    
    // MARK: - Add UI elements and setting constraints
    
    /// Add table view and setup constraints
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.register(WeatherTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    /// Add table header view
    private func setupTableHeaderView() {
        let header = TableHeaderView(frame: frame)
        header.add(mapView: mapView)
        tableView.tableHeaderView = header
    }
    
    // MARK: - Class methods
    
    /// Displays the received weather data in labels
    private func displayWeatherData() {
        viewModel?.setWeatherData = { [weak self] in
            guard let coordinate = self?.viewModel?.getCoordinates(),
                let cityName = self?.viewModel?.getCityName() else {
                    return
            }
            self?.title = cityName
            self?.showCityLocation(latitude: coordinate.lat, longitude: coordinate.lon, cityName: cityName)
            self?.tableView.reloadData()
        }
    }
    
    /// Displays the selected city on the map. Also puts a mark with the name of the selected city
    /// - Parameters:
    ///   - latitude: The latitude at which the selected city is located
    ///   - longitude: The longitude at which the selected city is located
    ///   - cityName: Name of the selected city
    private func showCityLocation(latitude: Double, longitude: Double, cityName: String) {
        let locationLatitude = CLLocationDegrees(floatLiteral: latitude)
        let locationLongitude = CLLocationDegrees(floatLiteral: longitude)
        let location = CLLocationCoordinate2D(latitude: locationLatitude, longitude: locationLongitude)
        let region = MKCoordinateRegion(center: location,
                                        latitudinalMeters: locationDistance,
                                        longitudinalMeters: locationDistance)
        let anotation = MKPointAnnotation()
        anotation.coordinate = location
        anotation.title = cityName
        mapView.addAnnotation(anotation)
        mapView.setRegion(region, animated: true)
    }
}

// MARK: - TableViewDelegate

extension WeatherViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

// MARK: - TableViewDataSource

extension WeatherViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRowsInSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? WeatherTableViewCell else { return UITableViewCell() }
        
        let weather = viewModel?.getData(at: indexPath.row)
        cell.weatherDataName.text = weather?.name
        cell.weatherDataValue.text = weather?.value
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - ScrollViewDelegate

extension WeatherViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let header = tableView.tableHeaderView as? TableHeaderView else { return }
        header.scrollViewDidScroll(scrollView: scrollView)
    }
}
