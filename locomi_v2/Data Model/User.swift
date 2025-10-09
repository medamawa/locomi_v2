//
//  User.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/08.
//

import Foundation
import FirebaseFirestore

struct User: Codable {
    @DocumentID var id: String?
    var uid: String
    var displayName: String
    var username: String
    var email: String
    var bio: String?

    var createdAt: Date

    var postsCount: Int
    var followersCount: Int
    var followingCount: Int

    init(uid: String, displayName: String, username: String, email: String, bio: String? = nil) {
        self.uid = uid
        self.displayName = displayName
        self.username = username
        self.email = email
        self.bio = bio
        self.createdAt = Date()
        self.postsCount = 0
        self.followersCount = 0
        self.followingCount = 0
    }
}

