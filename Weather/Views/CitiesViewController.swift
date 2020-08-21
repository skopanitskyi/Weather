//
//  CitiesViewController.swift
//  Weather
//
//  Created by Копаницкий Сергей on 18.08.2020.
//  Copyright © 2020 Копаницкий Сергей. All rights reserved.
//

import UIKit

/// Cities view controller displays all available cities
class CitiesViewController: UIViewController {
    
    // MARK: - Class instance
    
    /// Cities view model istance
    public var viewModel: CitiesViewModelProtocol?
    
    /// Reuse indentifier for cell
    private let reuseIdentifier = "Cell"
    
    /// Returns true if search bar is empty
    private var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    /// Returns true if data is entered into the search controller
    private var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    // MARK: - Create UI elements
    
    /// Create table view
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    /// Create search controller
    private var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search the city"
        searchController.obscuresBackgroundDuringPresentation = false
        return searchController
    }()
    
    /// Create activity indicator
    private var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    // MARK: - Class life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupActivityIndicator()
        setupTableView()
        fetchCitiesData()
    }
    
    // MARK: - Adding UI elements and setting constraints
    
    /// Setup cities view
    private func setupView() {
        view.backgroundColor = .white
        title = "Cities"
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    /// Add activity indicator and setup constraints
    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    /// Add table view and setup constraints
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CitiesTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    // MARK: - Class methods
    
    /// Requests city data
    private func fetchCitiesData() {
        viewModel?.updateTableView = { [weak self] in
            self?.activityIndicator.stopAnimating()
            self?.tableView.isHidden = false
            self?.tableView.reloadData()
        }
        viewModel?.getCities()
        tableView.isHidden = true
        activityIndicator.startAnimating()
    }
}

// MARK: - TableViewDelegate

extension CitiesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.pushController(at: indexPath.row, isFiltering: isFiltering)
    }
}

// MARK: - TableViewDataSource

extension CitiesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRowsInSection(isFiltering: isFiltering) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? CitiesTableViewCell else { return UITableViewCell() }
        
        cell.cityNameLabel.text = viewModel?.getCityName(at: indexPath.row, isFiltering: isFiltering)
        viewModel?.getImage(at: indexPath.row) { image in
            cell.cityImageView.image = image
        }
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - SearchResultsUpdating

extension CitiesViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let cityName = searchController.searchBar.text?.lowercased() else { return }
        viewModel?.getFilteredCities(name: cityName)
    }
}
