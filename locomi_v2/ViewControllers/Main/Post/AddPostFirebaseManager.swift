//
//  AddPostFirebaseManager.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/15.
//

import FirebaseFirestore

extension AddPostViewController {

    // Set new post to Firestore
    func savePostToFirestore(post: Post) {
        let db = Firestore.firestore()
        let collectionPosts = db.collection("posts")

        do {
            try collectionPosts
                .addDocument(from: post) { error in
                    DispatchQueue.main.async {
                        if let error = error {
                            let errorInfo = error.firestoreErrorInfo
                            self.showErrorAlert(title: errorInfo.title, message: errorInfo.message)
                        }

                        // success
                    }
                }

        } catch {
            self.showErrorAlert(title: "Error encoding post", message: error.localizedDescription)
        }
    }
}
