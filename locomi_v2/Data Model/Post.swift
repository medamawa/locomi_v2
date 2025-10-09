//
//  Post.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/08.
//

import FirebaseFirestore
import CoreLocation

struct Post: Codable {
    @DocumentID var id: String?
    var uid: String
    var content: String

    var latitude: Double
    var longitude: Double
    var locationName: String?
    var altitude: Double?
    var altitudeAccuracy: Double?

    var createdAt: Date
    var updatedAt: Date?

    var likesCount: Int
    var commentsCount: Int
    var viewsCount: Int

    var isPublic: Bool

    init(uid: String, content: String, latitude: Double, longitute: Double, locationName: String? = nil, altitude: Double? = nil, altitudeAccuracy: Double? = nil, isPublic: Bool = true) {
        self.uid = uid
        self.content = content
        self.latitude = latitude
        self.longitude = longitute
        self.locationName = locationName
        self.altitude = altitude
        self.altitudeAccuracy = altitudeAccuracy
        self.createdAt = Date()
        self.updatedAt = nil
        self.likesCount = 0
        self.commentsCount = 0
        self.viewsCount = 0
        self.isPublic = isPublic
    }

    init(uid: String, content: String, location: CLLocation, locationName: String? = nil, isPublic: Bool = true) {
        self.uid = uid
        self.content = content
        self.latitude = location.coordinate.latitude
        self.longitude = location.coordinate.longitude
        self.locationName = locationName
        self.createdAt = Date()
        self.updatedAt = nil
        self.likesCount = 0
        self.commentsCount = 0
        self.viewsCount = 0
        self.isPublic = isPublic

        if location.verticalAccuracy >= 0 {
            self.altitude = location.altitude
            self.altitudeAccuracy = location.verticalAccuracy
        }
    }

    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    
}
