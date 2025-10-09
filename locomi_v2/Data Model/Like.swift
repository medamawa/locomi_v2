//
//  Like.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/08.
//

import FirebaseFirestore

struct Like: Codable {
    @DocumentID var id: String?
    var postId: String
    var uid: String

    var createdAt: Date

    init(postId: String, uid: String) {
        self.postId = postId
        self.uid = uid
        self.createdAt = Date()
    }
}
