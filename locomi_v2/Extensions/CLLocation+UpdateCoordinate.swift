//
//  CLLocation+UpdateCoordinate.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/15.
//

import CoreLocation

extension CLLocation {

    func updateLocation(to coordinate: CLLocationCoordinate2D) -> CLLocation {
        return CLLocation(
            coordinate: coordinate,
            altitude: self.altitude,
            horizontalAccuracy: self.horizontalAccuracy,
            verticalAccuracy: self.verticalAccuracy,
            course: self.course,
            speed: self.speed,
            timestamp: self.timestamp
        )
    }
}
