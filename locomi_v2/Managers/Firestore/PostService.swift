//
//  PostService.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/20.
//

import FirebaseFirestore

final class PostService {
    private let db = Firestore.firestore()
    private let userService = UserService()

    // MARK: - Posts
    func getAllPosts(completion: @escaping ([Post]?, Error?) -> Void) {
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

    // MARK: - Posts with Users
    func getAllPostsWithUsers(completion: @escaping ([PostWithUser]?, Error?) -> Void) {
        db.collection("posts").getDocuments { [weak self] snapshot, error in
            guard let self = self else { return }

            if let error = error {
                completion(nil, error)
                return
            }

            guard let documents = snapshot?.documents else {
                completion([], nil)
                return
            }

            let posts = documents.compactMap { try? $0.data(as: Post.self) }
            var results: [PostWithUser] = []
            var userCache: [String: User] = [:]
            let group = DispatchGroup()

            for post in posts {
                group.enter()

                // Check user cache first
                if let cachedUser = userCache[post.uid] {
                    results.append(PostWithUser(post: post, user: cachedUser))
                    group.leave()
                    continue
                }

                // Fetch user via UserService
                userService.getUser(uid: post.uid) { user, error in
                    if let error = error {
                        print("Error fetching user: \(error.localizedDescription)")
                        results.append(PostWithUser(post: post, user: nil))
                    }

                    guard let user = user else { return }

                    userCache[post.uid] = user
                    results.append(PostWithUser(post: post, user: user))

                    group.leave()
                }
            }

            group.notify(queue: .main) {
                let sorted = results.sorted { $0.post.createdAt > $1.post.createdAt }
                completion(sorted, nil)
            }
        }
    }

    func savePost(_ post: Post, completion: @escaping (Error?) -> Void) {
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
