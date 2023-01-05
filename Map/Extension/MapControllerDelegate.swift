//
//  MapControllerDelegate.swift
//  Map
//
//  Created by Дмитрий Скок on 05.01.2023.
//

import Foundation
import MapKit

extension MapController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        renderer.strokeColor = .systemRed
        renderer.lineWidth = 4
        return renderer
    }
}
