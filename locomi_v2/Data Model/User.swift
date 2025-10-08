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
    var email: String
    var createdAt: Date

    init(uid: String, displayName: String, email: String, createdAt: Date) {
        self.uid = uid
        self.displayName = displayName
        self.email = email
        self.createdAt = createdAt
    }
}

