//
//  SignUpFirebaseManager.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/08.
//

import FirebaseAuth
import FirebaseFirestore

extension SignUpViewController {

    // Create a Firebase user with email and password
    func createUser(name: String, email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password, completion: {result, error in
            if error == nil {
                // MARK: the user creation is successful
                self.saveUserToFirestore(name: name, email: email)

            } else {
                // MARK: there is an error creating the user
                print("Error occured: \(String(describing: error))")
            }
        })
    }

    // Set the user information to Firestore after the account is created
    func saveUserToFirestore(name: String, email: String) {
        guard let currentUser = Auth.auth().currentUser else { return } // TODO: Error handling

        let db = Firestore.firestore()
        let collectionUsers = db.collection("users")
        let user = User(uid: currentUser.uid, displayName: name, email: email, createdAt: Date())

        do {
            try collectionUsers
                .document(currentUser.uid)
                .setData(from: user) { error in
                    if error == nil {
                        // Success to store
                    } else {
                        print("Error saving user: \(error!.localizedDescription)")
                    }
                }
        } catch {
            print("Error encoding user: \(error.localizedDescription)")
        }
    }

}
