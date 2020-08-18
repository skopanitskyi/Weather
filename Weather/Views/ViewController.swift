//
//  ViewController.swift
//  Weather
//
//  Created by Копаницкий Сергей on 18.08.2020.
//  Copyright © 2020 Копаницкий Сергей. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    public var viewModel: CitiesViewModelProtocol?
    
    private let reuseIdentifier = "Cell"
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var searchController: UISearchController = {
        let searchResultController = SearchResultViewController()
        searchResultController.viewModel = SearchResultViewModel()
        let searchController = UISearchController(searchResultsController: searchResultController)
        return searchController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Cities"
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        navigationController?.navigationBar.prefersLargeTitles = true
        setupTableView()
        loadData()
    }
    
    private func loadData() {
        viewModel?.getCities { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

// MARK: - TableViewDelegate

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}

// MARK: - TableViewDataSource

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRowsInSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! TableViewCell
        let image: Downloaded = indexPath.row % 2 == 0 ? .temp1 : .temp2
        viewModel?.getImage(image: image) { image in
            DispatchQueue.main.async {
                cell.cityImageView.image = image
            }
        }
        cell.cityNameLabel.text = viewModel?.getCityName(at: indexPath.row)

        return cell
    }
}

// MARK: - SearchResultsUpdating

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let resultsController = searchController.searchResultsController as? SearchResultViewController {
            guard let cityName = searchController.searchBar.text,
                  let filteredCities = viewModel?.getFilteredCities(name: cityName) else {
                    return
            }
            resultsController.viewModel?.setFilteredCities(cities: filteredCities)
        }
    }
}
