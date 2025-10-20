//
//  UserService.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/20.
//

import FirebaseFirestore

final class UserService {
    private let db = Firestore.firestore()

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
}
