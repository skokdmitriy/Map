//
//  MapView.swift
//  Map
//
//  Created by Дмитрий Скок on 05.01.2023.
//

import UIKit
import MapKit

class MapView: UIView {
    
    //    MARK: - Subviews
    let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    let addAddressButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "addAddress"), for: .normal)
        return button
    }()
    
    let routeButton = UIButton(title: "ROUTE", titleColor: .black, backgroundColor: .white, borderColor: UIColor.black.cgColor,  isHidden: true)
    let resetButton = UIButton(title: "RESET", titleColor: .black, backgroundColor: .white, borderColor: UIColor.black.cgColor,  isHidden: true)
    
    //    MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    MARK: - UI
    func setConstraint() {
        
        addSubview(mapView)
        addSubview(addAddressButton)
        addSubview(routeButton)
        addSubview(resetButton)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            mapView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            mapView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            mapView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            
            addAddressButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            addAddressButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            addAddressButton.heightAnchor.constraint(equalToConstant: 50),
            addAddressButton.widthAnchor.constraint(equalToConstant: 50),
            
            resetButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -5),
            resetButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            resetButton.heightAnchor.constraint(equalToConstant: 40),
            resetButton.widthAnchor.constraint(equalToConstant: 100),
            
            routeButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -5),
            routeButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            routeButton.heightAnchor.constraint(equalToConstant: 40),
            routeButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
}
