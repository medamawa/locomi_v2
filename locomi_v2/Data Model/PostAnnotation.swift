//
//  PostAnnotation.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/09.
//

import MapKit

class PostAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D

    let postWithUser: PostWithUser

    var isSelected: Bool = false

    init(postWithUser: PostWithUser) {
        self.postWithUser = postWithUser

        self.coordinate = postWithUser.post.coordinate

        super.init()
    }

    convenience init?(postWithUser: PostWithUser?) {
        guard let postWithUser = postWithUser else { return nil }

        self.init(postWithUser: postWithUser)
    }

    
}
