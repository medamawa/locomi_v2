//
//  ProfileViewController.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/07.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {

    var coordinator: ProfileCoordinator?

    var profileView = ProfileView()

    var currentUser = Auth.auth().currentUser!

    override func loadView() {
        view = profileView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapLogOut))

        if let email = currentUser.email {
            profileView.labelEmail.text = email
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
