//
//  Comment.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/08.
//

import FirebaseFirestore

struct Comment: Codable {
    @DocumentID var id: String?
    var postId: String
    var uid: String
    var content: String

    var createdAt: Date
    var updatedAt: Date?

    var likesCount: Int

    init(postId: String, uid: String, content: String) {
        self.postId = postId
        self.uid = uid
        self.content = content
        self.createdAt = Date()
        self.updatedAt = nil
        self.likesCount = 0
    }
}
