//
//  MapController.swift
//  Map
//
//  Created by Дмитрий Скок on 05.01.2023.
//

import UIKit
import MapKit
import CoreLocation

class MapController: UIViewController {
    
    // MARK: - Properties
    lazy var mapView = MapView()
    lazy var annotationsArray = [MKPointAnnotation]()
    
    // MARK: - Override methods
    override func loadView() {
        super.loadView()
        self.view = mapView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.mapView.delegate = self
        
        mapView.addAddressButton.addTarget(self, action: #selector(addAddressButtonTapped), for: .touchUpInside)
        mapView.routeButton.addTarget(self, action: #selector(routeButtonTapped), for: .touchUpInside)
        mapView.resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - @objc methods
    @objc func addAddressButtonTapped() {
        alertAddAddress(title: "Добавить", placeholder: "Введите адрес") { [self] (text) in
            setupPlacemark(addressPlace: text)
        }
    }
    
    @objc func routeButtonTapped() {
        print(annotationsArray)
        for index in 0...annotationsArray.count - 2 {
            createDirectionRequest(startCoordinate: annotationsArray[index].coordinate, destinationCoordinate: annotationsArray[index + 1].coordinate)
        }
        mapView.mapView.showAnnotations(annotationsArray, animated: true)
    }
    
    @objc func resetButtonTapped() {
        mapView.mapView.removeOverlays(mapView.mapView.overlays)
        mapView.mapView.removeAnnotations(mapView.mapView.annotations)
        annotationsArray = [MKPointAnnotation]()
        mapView.routeButton.isHidden = true
        mapView.resetButton.isHidden = true
    }
    
    // MARK: - Private methods
    private func setupPlacemark(addressPlace: String ) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressPlace) { [self] (placemarks, error) in
            if let  error = error {
                print(error)
                alertError(title: "Ошибка", message: "Сервер не доступен. Попробуйте добавить адрес еще раз")
                return
            }
            
            guard let placemarks = placemarks else { return }
            let placemark = placemarks.first
            let annotation = MKPointAnnotation()
            annotation.title = "\(addressPlace)"
            
            guard let placemarkLocation = placemark?.location else { return }
            annotation.coordinate = placemarkLocation.coordinate
            
            annotationsArray.append(annotation)
            
            if annotationsArray.count > 2 {
                mapView.routeButton.isHidden = false
                mapView.resetButton.isHidden = false
            }
            
            mapView.mapView.showAnnotations(annotationsArray, animated: true)
        }
    }
    
    private func createDirectionRequest (startCoordinate: CLLocationCoordinate2D, destinationCoordinate: CLLocationCoordinate2D) {
        
        let startLocation = MKPlacemark(coordinate: startCoordinate)
        let destinationLocation = MKPlacemark(coordinate: destinationCoordinate)
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: startLocation)
        request.destination = MKMapItem(placemark: destinationLocation)
        request.transportType = .walking
        request.requestsAlternateRoutes = true
        
        let direction = MKDirections(request: request)
        direction.calculate { (response, error) in
            
            if let error = error {
                print(error)
                return
            }
            
            guard let response = response else {
                self.alertError(title: "Ошибка", message: "Маршрут недоступен")
                print("error response")
                return
            }
            
            var minRoute = response.routes[0]
            print(minRoute)
            for route in response.routes{
                minRoute = (route.distance < minRoute.distance) ? route : minRoute
            }
            
            self.mapView.mapView.addOverlay(minRoute.polyline)
        }
    }
}

