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
    
    // MARK: - Class instance
    
    /// Number of labels that display information
    private let numberOfLabels: CGFloat = 6
    
    /// Distance in meters from the current location
    private let locationDistance: CLLocationDistance = 50000
    
    /// Weather view model instance
    public var viewModel: WeatherViewModelProtocol?
    
    /// Description label instance
    private lazy var descriptionLabel = createLabel("Description: ")
    
    /// Current temperature label instance
    private lazy var currentTemperatureLabel = createLabel("Current temperature: ")
    
    /// Max temperature label instance
    private lazy var maxTemperatureLabel = createLabel("Maximim temperature: ")
    
    /// Min temperature label instance
    private lazy var minTemperatureLabel = createLabel("Minimum temperature: ")
    
    /// Humidity label instance
    private lazy var humidityLabel = createLabel("Air humidity: ")
    
    /// Wind speed label instance
    private lazy var windSpeedLabel = createLabel("Wind speed: ")
    
    /// Description value instance
    private lazy var descriptionValue = createLabel(nil)
    
    /// Current temperature value instance
    private lazy var currentTemperatureValue = createLabel(nil)
    
    /// Max temperature value instance
    private lazy var maxTemperatureValue = createLabel(nil)
    
    /// Min temperature value instance
    private lazy var minTemperatureValue = createLabel(nil)
    
    /// Humidity value instance
    private lazy var humidityValue = createLabel(nil)
    
    /// Wind speed value instance
    private lazy var windSpeedValue = createLabel(nil)
    
    // MARK: - Create UI elements
    
    /// Create map view
    private var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.showsScale = true
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    /// Creates a label
    /// - Parameter text: The text to be displayed on the label
    private func createLabel(_ text: String?) -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = text
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    // MARK: - Class life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupMapView()
        setupDescriptionLabel()
        setupCurrentTemperatureLabel()
        setupMaxTemperatureLabel()
        setupMinTemperatureLabel()
        setupHumidityLabel()
        setupWindSpeedLabel()
        setupDescriptionValue()
        setupCurrentTemperatureValue()
        setupMaxTemperatureValue()
        setupMinTemperatureValue()
        setupHumidityValue()
        setupWindSpeedValue()
        displayWeatherData()
    }
    
    // MARK: - Add UI elements and setting constraints
    
    /// Add map view and setup constraints
    private func setupMapView() {
        view.addSubview(mapView)
        mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mapView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5).isActive = true
    }
    
    /// Add description label and setup constraints
    private func setupDescriptionLabel() {
        view.addSubview(descriptionLabel)
        descriptionLabel.topAnchor.constraint(equalTo: mapView.bottomAnchor).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        descriptionLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        descriptionLabel.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5 / numberOfLabels).isActive = true
    }
    
    /// Add current temperature label and setup constraints
    private func setupCurrentTemperatureLabel() {
        view.addSubview(currentTemperatureLabel)
        currentTemperatureLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor).isActive = true
        currentTemperatureLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        currentTemperatureLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        currentTemperatureLabel.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5 / numberOfLabels).isActive = true
    }
    
    /// Add max temperature label and setup constraints
    private func setupMaxTemperatureLabel() {
        view.addSubview(maxTemperatureLabel)
        maxTemperatureLabel.topAnchor.constraint(equalTo: currentTemperatureLabel.bottomAnchor).isActive = true
        maxTemperatureLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        maxTemperatureLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        maxTemperatureLabel.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5 / numberOfLabels).isActive = true
    }
    
    /// Add min temperature label and setup constraints
    private func setupMinTemperatureLabel() {
        view.addSubview(minTemperatureLabel)
        minTemperatureLabel.topAnchor.constraint(equalTo: maxTemperatureLabel.bottomAnchor).isActive = true
        minTemperatureLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        minTemperatureLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        minTemperatureLabel.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5 / numberOfLabels).isActive = true
    }
    
    /// Add humidity label and setup constraints
    private func setupHumidityLabel() {
        view.addSubview(humidityLabel)
        humidityLabel.topAnchor.constraint(equalTo: minTemperatureLabel.bottomAnchor).isActive = true
        humidityLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        humidityLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        humidityLabel.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5 / numberOfLabels).isActive = true
    }
    
    /// Add wind speed label and setup constraints
    private func setupWindSpeedLabel() {
        view.addSubview(windSpeedLabel)
        windSpeedLabel.topAnchor.constraint(equalTo: humidityLabel.bottomAnchor).isActive = true
        windSpeedLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        windSpeedLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        windSpeedLabel.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5 / numberOfLabels).isActive = true
    }
    
    /// Add description value  and setup constraints
    private func setupDescriptionValue() {
        view.addSubview(descriptionValue)
        descriptionValue.topAnchor.constraint(equalTo: mapView.bottomAnchor).isActive = true
        descriptionValue.leadingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor, constant: 10).isActive = true
        descriptionValue.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        descriptionValue.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5 / numberOfLabels).isActive = true
    }
    
    /// Add current temperature value  and setup constraints
    private func setupCurrentTemperatureValue() {
        view.addSubview(currentTemperatureValue)
        currentTemperatureValue.topAnchor.constraint(equalTo: descriptionValue.bottomAnchor).isActive = true
        currentTemperatureValue.leadingAnchor.constraint(equalTo: currentTemperatureLabel.trailingAnchor, constant: 10).isActive = true
        currentTemperatureValue.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        currentTemperatureValue.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5 / numberOfLabels).isActive = true
    }
    
    /// Add max temperature value  and setup constraints
    private func setupMaxTemperatureValue() {
        view.addSubview(maxTemperatureValue)
        maxTemperatureValue.topAnchor.constraint(equalTo: (currentTemperatureValue).bottomAnchor).isActive = true
        maxTemperatureValue.leadingAnchor.constraint(equalTo: maxTemperatureLabel.trailingAnchor, constant: 10).isActive = true
        maxTemperatureValue.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        maxTemperatureValue.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5 / numberOfLabels).isActive = true
    }
    
    /// Add min temperature value  and setup constraints
    private func setupMinTemperatureValue() {
        view.addSubview(minTemperatureValue)
        minTemperatureValue.topAnchor.constraint(equalTo: maxTemperatureValue.bottomAnchor).isActive = true
        minTemperatureValue.leadingAnchor.constraint(equalTo: minTemperatureLabel.trailingAnchor, constant: 10).isActive = true
        minTemperatureValue.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        minTemperatureValue.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5 / numberOfLabels).isActive = true
    }
    
    /// Add humidity value  and setup constraints
    private func setupHumidityValue() {
        view.addSubview(humidityValue)
        humidityValue.topAnchor.constraint(equalTo: minTemperatureValue.bottomAnchor).isActive = true
        humidityValue.leadingAnchor.constraint(equalTo: humidityLabel.trailingAnchor, constant: 10).isActive = true
        humidityValue.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        humidityValue.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5 / numberOfLabels).isActive = true
    }
    
    /// Add wind speed value  and setup constraints
    private func setupWindSpeedValue() {
        view.addSubview(windSpeedValue)
        windSpeedValue.topAnchor.constraint(equalTo: humidityValue.bottomAnchor).isActive = true
        windSpeedValue.leadingAnchor.constraint(equalTo: windSpeedLabel.trailingAnchor, constant: 10).isActive = true
        windSpeedValue.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        windSpeedValue.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5 / numberOfLabels).isActive = true
    }
    
    // MARK: - Class methods
    
    /// Displays the received weather data in labels
    private func displayWeatherData() {
        viewModel?.setWeatherData = { [weak self] weatherData in
            self?.title = weatherData.name
            self?.descriptionValue.text = weatherData.weather.first?.description
            self?.currentTemperatureValue.text = "\(weatherData.main.temp) ºC"
            self?.maxTemperatureValue.text = "\(weatherData.main.temp_max) ºC"
            self?.minTemperatureValue.text = "\(weatherData.main.temp_min) ºC"
            self?.humidityValue.text = "\(weatherData.main.humidity) %"
            self?.windSpeedValue.text = "\(weatherData.wind.speed) km/h"
            self?.showCityLocation(latitude: weatherData.coord.lat,
                                   longitude: weatherData.coord.lon,
                                   cityName: weatherData.name)
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
