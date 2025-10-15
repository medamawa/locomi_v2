//
//  MKMapView+SetRegion.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/14.
//

import MapKit

extension MKMapView {

    func centerToLocation(location: CLLocation, radius: CLLocationDistance = 500) {
        let corrdinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: radius,
            longitudinalMeters: radius
        )
        setRegion(corrdinateRegion, animated: true)
    }
}
