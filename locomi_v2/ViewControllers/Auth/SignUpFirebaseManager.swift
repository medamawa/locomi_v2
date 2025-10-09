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
    func createUser(displayName: String, username: String, email: String, password: String, bio: String?) {
        Auth.auth().createUser(withEmail: email, password: password, completion: {result, error in
            if error == nil {
                // MARK: the user creation is successful
                let user = User(uid: result!.user.uid, displayName: displayName, username: username, email: email, bio: bio)
                self.saveUserToFirestore(user: user)

            } else {
                // MARK: there is an error creating the user
                let errorInfo = error!.firebaseAuthErrorInfo
                self.showErrorAlert(title: errorInfo.title, message: errorInfo.message)
            }
        })
    }

    // Set the user information to Firestore after the account is created
    func saveUserToFirestore(user: User) {
        let db = Firestore.firestore()
        let collectionUsers = db.collection("users")

        do {
            try collectionUsers
                .document(user.uid)
                .setData(from: user) { error in
                    if error == nil {
                        // Success to store
                    } else {
                        let errorInfo = error!.firestoreErrorInfo
                        self.showErrorAlert(title: errorInfo.title, message: errorInfo.message)
                    }
                }
        } catch {
            self.showErrorAlert(title: "Error encoding user", message: error.localizedDescription)
        }
    }

}
