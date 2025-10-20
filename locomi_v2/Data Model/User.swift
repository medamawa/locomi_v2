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
    var profileImageURL: String?
    var bio: String?

    var createdAt: Date
    var updatedAt: Date?

    var postsCount: Int
    var followersCount: Int
    var followingCount: Int

    init(uid: String, displayName: String, username: String, email: String, profileImageURL: URL? = nil, bio: String? = nil) {
        self.uid = uid
        self.displayName = displayName
        self.username = username
        self.email = email
        self.profileImageURL = profileImageURL?.absoluteString
        self.bio = bio
        self.createdAt = Date()
        self.postsCount = 0
        self.followersCount = 0
        self.followingCount = 0
    }

    func loadProfileImage() async -> UIImage {
        if let urlString = profileImageURL,
           !urlString.isEmpty,
           let url = URL(string: urlString) {
            if let cached = await ImageCache.shared.image(for: urlString) {
                return cached
            }
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                if let image = UIImage(data: data) {
                    await ImageCache.shared.set(image, for: urlString)
                    return image
                }
            } catch {
                print("Failed to load profile image: \(error)")
            }

        }
        return UIImage(systemName: "person.fill")!
    }
}

actor ImageCache {
    static let shared = ImageCache()
    private var cache: [String: UIImage] = [:]

    func image(for url: String) -> UIImage? {
        cache[url]
    }

    func set(_ image: UIImage, for url: String) {
        cache[url] = image
    }
}
