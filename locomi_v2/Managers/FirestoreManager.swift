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

    func getAllPostsWithUsers(completion: @escaping ([PostWithUser]?, Error?) -> Void) {
        let db = Firestore.firestore()

        db.collection("posts").getDocuments { snapshot, error in
            if let error = error {
                completion(nil, error)
                return
            }

            guard let documents = snapshot?.documents else {
                completion([], nil)
                return
            }

            var results: [PostWithUser] = []
            let group = DispatchGroup()

            for document in documents {
                if let post = try? document.data(as: Post.self) {
                    group.enter()
                    db.collection("users")
                        .whereField("uid", isEqualTo: post.uid)
                        .getDocuments { userSnapshot, _ in
                            let user = try? userSnapshot?.documents.first?.data(as: User.self)
                            results.append(PostWithUser(post: post, user: user))
                            group.leave()
                        }
                }
            }

            group.notify(queue: .main) {
                let sorted = results.sorted { $0.post.createdAt > $1.post.createdAt }
                completion(sorted, nil)
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
