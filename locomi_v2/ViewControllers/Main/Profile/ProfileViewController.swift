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

    // MARK: - Properties
    var coordinator: ProfileCoordinator?

    let profileView = ProfileView()
    private var user: User?
    private var isCurrentUser: Bool

    // MARK: - Initializers
    /// For displaying the current user's profile
    init() {
        self.isCurrentUser = true
        super.init(nibName: nil, bundle: nil)
    }

    /// For displaying another user's profile
    init(user: User) {
        self.user = user
        self.isCurrentUser = false
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func loadView() {
        view = profileView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        setupActions()
        setupUserInfo()
    }

    // MARK: - Setup
    func setupActions() {
        profileView.buttonLogout.addTarget(self, action: #selector(didTapLogOut), for: .touchUpInside)
    }

    func setupUserInfo() {
        if let user = self.user {
            // If a User is passed in
            configure(with: user)
        } else if let currentUser = Auth.auth().currentUser {
            // Fetch the current user's profile from Firestore
            fetchUserInfo(uid: currentUser.uid)
        }
    }

    func fetchUserInfo(uid: String) {
        Firestore.firestore()
            .collection("users")
            .document(uid)
            .getDocument { [weak self] (document, error) in
                guard let self = self else { return }

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
                        self.configure(with: user)
                    }
                } catch {
                    print("Error decoding user: \(error.localizedDescription)")
                }
            }
    }

    func configure(with user: User) {
        profileView.labelName.text = user.displayName
        profileView.labelUsername.text = "@\(user.username)"
        profileView.labelBio.text = user.bio ?? "I'm nothing... :|"
        profileView.labelPostsCount.text = "\(user.postsCount)"
        profileView.labelFollowersCount.text = "\(user.followersCount)"
        profileView.labelFollowingCount.text = "\(user.followingCount)"

        // Hide the logout button when viewing another user's profile
        profileView.buttonLogout.isHidden = !isCurrentUser
    }

    // MARK: - Actions
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
