//
//  PostAnnotation.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/09.
//

import MapKit

class PostAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D

    let post: Post
    
    var isSelected: Bool = false

    init(post: Post) {
        self.post = post

        self.coordinate = post.coordinate

        super.init()
    }

    convenience init?(post: Post?) {
        guard let post = post else { return nil }

        self.init(post: post)
    }

    
}
