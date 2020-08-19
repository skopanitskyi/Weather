//
//  WeatherViewController.swift
//  Weather
//
//  Created by Копаницкий Сергей on 19.08.2020.
//  Copyright © 2020 Копаницкий Сергей. All rights reserved.
//

import UIKit
import MapKit

class WeatherViewController: UIViewController {
    
    public var viewModel: WeatherViewModelProtocol?
    
    private var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.showsScale = true
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    private lazy var descriptionLabel = createLabel(text: "Description: ")
    
    private lazy var currentTemperatureLabel = createLabel(text: "Current temperature: ")
    
    private lazy var maxTemperatureLabel = createLabel(text: "Maximim temperature: ")
    
    private lazy var minTemperatureLabel = createLabel(text: "Minimum temperature: ")
    
    private lazy var humidityLabel = createLabel(text: "Air humidity: ")
    
    private lazy var windSpeedLabel = createLabel(text: "Wind speed: ")
    
    private lazy var descriptionValueLabel = createLabel(text: nil)
    
    private lazy var currentTemperatureValueLabel = createLabel(text: nil)
    
    private lazy var maxTemperatureValueLabel = createLabel(text: nil)

    private lazy var minTemperatureValueLabel = createLabel(text: nil)

    private lazy var humidityValueLabel = createLabel(text: nil)

    private lazy var windSpeedValueLabel = createLabel(text: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Weather"
        setupConstraintsForMapView()
        setupConstraintsForDescriptionLabel()
        setupConstraintsForCurrentTemperatureLabel()
        setupConstraintsForMaxTemperatureLabel()
        setupConstraintsForMinTemperatureLabel()
        setupConstraintsForHumidityLabel()
        setupConstraintsForWindSpeedLabel()
        setupConstraintsForDescriptionValueLabel()
        setupConstraintsForCurrentTemperatureValueLabel()
        setupConstraintsForMaxTemperatureValueLabel()
        setupConstraintsForMinTemperatureValueLabel()
        setupConstraintsForHumidityValueLabel()
        setupConstraintsForWindSpeedValueLabel()
        
        viewModel?.data = { [weak self] weatherData in
            self?.descriptionValueLabel.text = weatherData.weather.first?.description
            self?.currentTemperatureValueLabel.text = "\(weatherData.main.temp) ºC"
            self?.maxTemperatureValueLabel.text = "\(weatherData.main.temp_max) ºC"
            self?.minTemperatureValueLabel.text = "\(weatherData.main.temp_min) ºC"
            self?.humidityValueLabel.text = "\(weatherData.main.humidity) %"
            self?.windSpeedValueLabel.text = "\(weatherData.wind.speed) km/h"
            let location = CLLocationCoordinate2D(latitude: CLLocationDegrees(floatLiteral: weatherData.coord.lat), longitude: CLLocationDegrees(floatLiteral: weatherData.coord.lon))
            let anotation = MKPointAnnotation()
            anotation.coordinate = location
            anotation.title = weatherData.name
            self?.mapView.addAnnotation(anotation)
            let distance: CLLocationDistance = 50000
            self?.mapView.setRegion(MKCoordinateRegion(center: location, latitudinalMeters: distance, longitudinalMeters: distance), animated: true)
        }
    }
    
    private func setupConstraintsForMapView() {
        view.addSubview(mapView)
        mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mapView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5).isActive = true
    }
    
    private func setupConstraintsForDescriptionLabel() {
        view.addSubview(descriptionLabel)
        descriptionLabel.topAnchor.constraint(equalTo: mapView.bottomAnchor).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        descriptionLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        descriptionLabel.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5 / 6).isActive = true
    }
    
    private func setupConstraintsForCurrentTemperatureLabel() {
        view.addSubview(currentTemperatureLabel)
        currentTemperatureLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor).isActive = true
        currentTemperatureLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        currentTemperatureLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        currentTemperatureLabel.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5 / 6).isActive = true
    }
    
    private func setupConstraintsForMaxTemperatureLabel() {
        view.addSubview(maxTemperatureLabel)
        maxTemperatureLabel.topAnchor.constraint(equalTo: currentTemperatureLabel.bottomAnchor).isActive = true
        maxTemperatureLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        maxTemperatureLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        maxTemperatureLabel.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5 / 6).isActive = true
    }
    
    private func setupConstraintsForMinTemperatureLabel() {
        view.addSubview(minTemperatureLabel)
        minTemperatureLabel.topAnchor.constraint(equalTo: maxTemperatureLabel.bottomAnchor).isActive = true
        minTemperatureLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        minTemperatureLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        minTemperatureLabel.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5 / 6).isActive = true
    }
    
    private func setupConstraintsForHumidityLabel() {
        view.addSubview(humidityLabel)
        humidityLabel.topAnchor.constraint(equalTo: minTemperatureLabel.bottomAnchor).isActive = true
        humidityLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        humidityLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        humidityLabel.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5 / 6).isActive = true
    }
    
    private func setupConstraintsForWindSpeedLabel() {
        view.addSubview(windSpeedLabel)
        windSpeedLabel.topAnchor.constraint(equalTo: humidityLabel.bottomAnchor).isActive = true
        windSpeedLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        windSpeedLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        windSpeedLabel.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5 / 6).isActive = true
    }
    
    private func setupConstraintsForDescriptionValueLabel() {
        view.addSubview(descriptionValueLabel)
        descriptionValueLabel.topAnchor.constraint(equalTo: mapView.bottomAnchor).isActive = true
        descriptionValueLabel.leadingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor, constant: 10).isActive = true
        descriptionValueLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        descriptionValueLabel.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5 / 6).isActive = true
    }
    
    private func setupConstraintsForCurrentTemperatureValueLabel() {
        view.addSubview(currentTemperatureValueLabel)
        currentTemperatureValueLabel.topAnchor.constraint(equalTo: descriptionValueLabel.bottomAnchor).isActive = true
        currentTemperatureValueLabel.leadingAnchor.constraint(equalTo: currentTemperatureLabel.trailingAnchor, constant: 10).isActive = true
        currentTemperatureValueLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        currentTemperatureValueLabel.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5 / 6).isActive = true
    }
    
    private func setupConstraintsForMaxTemperatureValueLabel() {
        view.addSubview(maxTemperatureValueLabel)
        maxTemperatureValueLabel.topAnchor.constraint(equalTo: (currentTemperatureValueLabel).bottomAnchor).isActive = true
        maxTemperatureValueLabel.leadingAnchor.constraint(equalTo: maxTemperatureLabel.trailingAnchor, constant: 10).isActive = true
        maxTemperatureValueLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        maxTemperatureValueLabel.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5 / 6).isActive = true
    }
    
    private func setupConstraintsForMinTemperatureValueLabel() {
        view.addSubview(minTemperatureValueLabel)
        minTemperatureValueLabel.topAnchor.constraint(equalTo: maxTemperatureValueLabel.bottomAnchor).isActive = true
        minTemperatureValueLabel.leadingAnchor.constraint(equalTo: minTemperatureLabel.trailingAnchor, constant: 10).isActive = true
        minTemperatureValueLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        minTemperatureValueLabel.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5 / 6).isActive = true
    }
    
    private func setupConstraintsForHumidityValueLabel() {
        view.addSubview(humidityValueLabel)
        humidityValueLabel.topAnchor.constraint(equalTo: minTemperatureValueLabel.bottomAnchor).isActive = true
        humidityValueLabel.leadingAnchor.constraint(equalTo: humidityLabel.trailingAnchor, constant: 10).isActive = true
        humidityValueLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        humidityValueLabel.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5 / 6).isActive = true
    }
    
    private func setupConstraintsForWindSpeedValueLabel() {
        view.addSubview(windSpeedValueLabel)
        windSpeedValueLabel.topAnchor.constraint(equalTo: humidityValueLabel.bottomAnchor).isActive = true
        windSpeedValueLabel.leadingAnchor.constraint(equalTo: windSpeedLabel.trailingAnchor, constant: 10).isActive = true
        windSpeedValueLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        windSpeedValueLabel.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5 / 6).isActive = true
    }
    
    private func createLabel(text: String?) -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = text
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}
