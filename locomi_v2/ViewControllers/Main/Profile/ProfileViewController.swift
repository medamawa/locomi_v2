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
        profileView.buttonEditProfile.addTarget(self, action: #selector(didTapEditProfile), for: .touchUpInside)
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
        FirestoreManager.shared.userService.getUser(uid: uid) { currentUser, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.showErrorAlert(title: "Failed to fetch user", message: error.localizedDescription)
                    return
                }

                guard let currentUser = currentUser else { return }

                self.user = currentUser
                self.configure(with: currentUser)
            }
        }
    }

    func configure(with user: User) {
        Task {
            profileView.imageProfile.image = await user.loadProfileImage()
        }
        profileView.labelName.text = user.displayName
        profileView.labelUsername.text = "@\(user.username)"
        profileView.labelBio.text = user.bio ?? "I'm nothing... :|"
        profileView.labelPostsCount.text = "\(user.postsCount)"
        profileView.labelFollowersCount.text = "\(user.followersCount)"
        profileView.labelFollowingCount.text = "\(user.followingCount)"

        // Hide buttons and add a cancel button when viewing another user's profile
        if !isCurrentUser {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapBack))
            profileView.buttonEditProfile.isHidden = true
            profileView.buttonLogout.isHidden = true
        }
    }

    // MARK: - Update
    func updateUser(_ user: User) {
        self.user = user
        self.configure(with: user)
    }

    // MARK: - Actions
    @objc func didTapBack() {
        self.navigationController?.popViewController(animated: true)
    }

    @objc func didTapEditProfile() {
        guard let user = self.user else { return }
        self.coordinator?.showEditProfile(for: user)
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
