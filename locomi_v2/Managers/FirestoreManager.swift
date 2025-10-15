//
//  FirestoreManager.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/15.
//

import FirebaseFirestore

class FirestoreManager {

    static let shared = FirestoreManager()

    private init() {}

    func getAllPosts(completion: @escaping ([Post]?, Error?) -> Void) {
        let db = Firestore.firestore()
        db.collection("posts")
            .getDocuments { snapshot, error in
            if let error = error {
                completion(nil, error)
            } else {
                let posts = snapshot?.documents.compactMap { try? $0.data(as: Post.self) }
                completion(posts, nil)
            }
        }
    }

    func savePost(_ post: Post, completion: @escaping (Error?) -> Void) {
        let db = Firestore.firestore()
        do {
            try db.collection("posts")
                .addDocument(from: post) { error in
                completion(error)
            }
        } catch {
            completion(error)
        }
    }

}
