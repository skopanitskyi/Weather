//
//  CityModel.swift
//  Weather
//
//  Created by Копаницкий Сергей on 18.08.2020.
//  Copyright © 2020 Копаницкий Сергей. All rights reserved.
//

import Foundation

//{
//    "id": 2960,
//    "name": "‘Ayn Ḩalāqīm",
//    "state": "",
//    "country": "SY",
//    "coord": {
//        "lon": 36.321911,
//        "lat": 34.940079
//    }
//},

struct CityModel: Codable {
    public let id: Int
    public let name: String
    public let state: String
    public let country: String
    public let coord: Coordinates
}

struct Coordinates: Codable {
    public let lon: Double
    public let lat: Double
}
