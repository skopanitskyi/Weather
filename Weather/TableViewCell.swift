//
//  TableViewCell.swift
//  Weather
//
//  Created by Копаницкий Сергей on 18.08.2020.
//  Copyright © 2020 Копаницкий Сергей. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    public var cityImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    public var cityNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .natural
        label.font = UIFont.systemFont(ofSize: 19)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCityImageView()
        setupCityNameLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCityImageView() {
        addSubview(cityImageView)
        cityImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        cityImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        cityImageView.heightAnchor.constraint(equalToConstant: 65).isActive = true
        cityImageView.widthAnchor.constraint(equalToConstant: 65).isActive = true
    }
    
    private func setupCityNameLabel() {
        addSubview(cityNameLabel)
        cityNameLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        cityNameLabel.leadingAnchor.constraint(equalTo: cityImageView.safeAreaLayoutGuide.trailingAnchor, constant: 10).isActive = true
        cityNameLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        cityNameLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
    }
}
