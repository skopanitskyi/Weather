//
//  WeatherTableViewCell.swift
//  Weather
//
//  Created by Копаницкий Сергей on 21.08.2020.
//  Copyright © 2020 Копаницкий Сергей. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    public var weatherDataName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public var weatherDataValue: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Class constructors
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupWeatherDataName()
        setupWeatherDataValue()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupWeatherDataName() {
        contentView.addSubview(weatherDataName)
        weatherDataName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        weatherDataName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        weatherDataName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        weatherDataName.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5).isActive = true
    }
    
    private func setupWeatherDataValue() {
        contentView.addSubview(weatherDataValue)
        weatherDataValue.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        weatherDataValue.leadingAnchor.constraint(equalTo: weatherDataName.trailingAnchor, constant: 5).isActive = true
        weatherDataValue.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        weatherDataValue.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
    }
}
