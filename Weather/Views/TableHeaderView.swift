//
//  TableHeaderView.swift
//  Weather
//
//  Created by Копаницкий Сергей on 23.08.2020.
//  Copyright © 2020 Копаницкий Сергей. All rights reserved.
//

import UIKit
import MapKit

/// Map header view for table view
class TableHeaderView: UIView {
    
    // MARK: - Class instances
    
    /// Map view height constraint
    private var mapViewHeight = NSLayoutConstraint()
    
    /// Map view bottom constraint
    private var mapViewBottom = NSLayoutConstraint()
    
    /// Container view height constraint
    private var containerViewHeight = NSLayoutConstraint()

    /// Container view
    private var containerView: UIView = UIView()
    
    /// Map view
    private var mapView: MKMapView?
    
    // MARK: - Class constructors
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Class methods
    
    /// Adds the resulting map view to the container view
    /// - Parameter mapView: Map view which will be rendered as header view
    public func add(mapView: MKMapView) {
        addSubview(containerView)
        containerView.addSubview(mapView)
        self.mapView = mapView
        setViewConstraints()
    }
    
    /// Adds constraints for views
    private func setViewConstraints() {
        
        /// UIView Constraints
        self.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        self.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        self.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        
        /// Container View Constraints
        guard let mapView = self.mapView else { return }
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.widthAnchor.constraint(equalTo: mapView.widthAnchor).isActive = true
        containerViewHeight = containerView.heightAnchor.constraint(equalTo: heightAnchor)
        containerViewHeight.isActive = true
        
        /// ImageView Constraints
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapViewBottom = mapView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        mapViewHeight = mapView.heightAnchor.constraint(equalTo: containerView.heightAnchor)
        mapViewBottom.isActive = true
        mapViewHeight.isActive = true
    }
    
    /// Resizes constraints for map view when scrolling table view
    /// - Parameter mapView: Scroll view
    public func scrollViewDidScroll(scrollView: UIScrollView) {
        containerViewHeight.constant = scrollView.contentInset.top
        let offsetY = -(scrollView.contentOffset.y + scrollView.contentInset.top)
        containerView.clipsToBounds = offsetY <= 0
        mapViewBottom.constant = offsetY >= 0 ? 0 : -offsetY / 2
        mapViewHeight.constant = max(offsetY + scrollView.contentInset.top, scrollView.contentInset.top)
    }
}
