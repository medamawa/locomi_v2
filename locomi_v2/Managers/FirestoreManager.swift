//
//  FirestoreManager.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/15.
//

import FirebaseFirestore

class FirestoreManager {

    static let shared = FirestoreManager()
    let userService = UserService()
    let postService = PostService()

    private init() {}

}
