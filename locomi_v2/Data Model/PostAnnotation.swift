//
//  PostAnnotation.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/09.
//

import MapKit

class PostAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?

    let post: Post
    
    var isSelected: Bool = false

    init(post: Post) {
        self.post = post

        self.coordinate = post.coordinate
        self.title = post.locationName ?? "Post"

        if post.content.count > 20 {
            self.subtitle = String(post.content.prefix(20)) + "..."
        } else {
            self.subtitle = post.content
        }

        super.init()
    }

    convenience init?(post: Post?) {
        guard let post = post else { return nil }

        self.init(post: post)
    }
}
