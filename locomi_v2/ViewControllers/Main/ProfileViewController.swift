//
//  ProfileViewController.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/07.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ProfileViewController: UIViewController {

    var coordinator: ProfileCoordinator?

    var profileView = ProfileView()

    var currentUser = Auth.auth().currentUser!
    var uid: String? = nil

    override func loadView() {
        view = profileView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        profileView.buttonLogout.addTarget(self, action: #selector(didTapLogOut), for: .touchUpInside)

        if (uid == nil) {
            uid = currentUser.uid
        }
        setupUserInfo(uid: self.uid!)
    }

    func setupUserInfo(uid: String) {
        let db = Firestore.firestore()

        db.collection("users")
            .document(uid)
            .getDocument { (document, error) in
                if let error = error {
                    print("Error fetching user: \(error.localizedDescription)")
                    return
                }

                guard let document = document, document.exists else {
                    print("User document does not exist")
                    return
                }

                do {
                    let user: User = try document.data(as: User.self)

                    DispatchQueue.main.async {
                        self.profileView.labelName.text = user.displayName
                        self.profileView.labelUsername.text = "@\(user.username)"
                        self.profileView.labelBio.text = user.bio ?? "I'm nothing... :|"
                        self.profileView.labelPostsCount.text = "\(user.postsCount)"
                        self.profileView.labelFollowersCount.text = "\(user.followersCount)"
                        self.profileView.labelFollowingCount.text = "\(user.followingCount)"
                    }

                } catch {
                    print("Error decoding user: \(error.localizedDescription)")
                }
            }
    }

    @objc func didTapLogOut() {
        let logoutAlert = UIAlertController(title: "Logging out", message: "Are you sure want to log out?", preferredStyle: .actionSheet)
        logoutAlert.addAction(UIAlertAction(title: "Yes, log out", style: .default, handler: {(_) in
            do {
                try Auth.auth().signOut()
            } catch {
                print("Error occured")
            }
        }))
        logoutAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        self.present(logoutAlert, animated: true)
    }

}
