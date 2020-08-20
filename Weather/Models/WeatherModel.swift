//
//  WeatherModel.swift
//  Weather
//
//  Created by Копаницкий Сергей on 19.08.2020.
//  Copyright © 2020 Копаницкий Сергей. All rights reserved.
//

import Foundation

/// Weather model
struct WeatherModel: Codable {
    public let coord: Coordinate
    public let weather: [Weather]
    public let main: Main
    public let wind: Wind
    public let name: String
}

struct Coordinate: Codable {
    public let lon: Double
    public let lat: Double
}

struct Weather: Codable {
    public let description: String
}

struct Main: Codable {
    public let temp: Double
    public let temp_min: Double
    public let temp_max: Double
    public let humidity: Double
}

struct Wind: Codable {
    public let speed: Double
}
