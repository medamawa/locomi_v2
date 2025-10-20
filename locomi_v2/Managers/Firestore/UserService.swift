//
//  UserService.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/20.
//

import FirebaseFirestore

final class UserService {
    private let db = Firestore.firestore()

    // MARK: - Save (create new user)
    func saveUser(_ user: User, completion: @escaping (Error?) -> Void) {
        do {
            try db.collection("users").document(user.uid).setData(from: user) { error in
                completion(error)
            }
        } catch {
            completion(error)
        }
    }

    // MARK: - Get one user
    func getUser(uid: String, completion: @escaping (User?, Error?) -> Void) {
        db.collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                completion(nil, error)
            } else {
                let user = try? snapshot?.data(as: User.self)
                completion(user, nil)
            }
        }
    }

    // MARK: - Get all users
    func getAllUsers(completion: @escaping ([User]?, Error?) -> Void) {
        db.collection("users").getDocuments { snapshot, error in
            if let error = error {
                completion(nil, error)
            } else {
                let users = snapshot?.documents.compactMap { try? $0.data(as: User.self) }
                completion(users, nil)
            }
        }
    }

    // MARK: - Update (partial update)
    func updateUser(uid: String, fields: [String: Any], completion: @escaping (Error?) -> Void) {
        db.collection("users").document(uid).updateData(fields) { error in
            completion(error)
        }
    }
}
