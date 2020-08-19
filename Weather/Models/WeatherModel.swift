//
//  WeatherModel.swift
//  Weather
//
//  Created by Копаницкий Сергей on 19.08.2020.
//  Copyright © 2020 Копаницкий Сергей. All rights reserved.
//

import Foundation

//{
//    "coord": {
//        "lon": 37.5,
//        "lat": 50.75
//    },
//    "weather": [
//        {
//            "id": 803,
//            "main": "Clouds",
//            "description": "broken clouds",
//            "icon": "04d"
//        }
//    ],
//    "base": "stations",
//    "main": {
//        "temp": 31,
//        "feels_like": 28.19,
//        "temp_min": 31,
//        "temp_max": 31,
//        "pressure": 1009,
//        "humidity": 27
//    },
//    "visibility": 10000,
//    "wind": {
//        "speed": 4,
//        "deg": 230
//    },
//    "clouds": {
//        "all": 63
//    },
//    "dt": 1597837016,
//    "sys": {
//        "type": 1,
//        "id": 9030,
//        "country": "RU",
//        "sunrise": 1597803858,
//        "sunset": 1597855390
//    },
//    "timezone": 10800,
//    "id": 578071,
//    "name": "Belgorod Oblast",
//    "cod": 200
//}

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
