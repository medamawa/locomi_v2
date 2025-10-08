//
//  SignUpViewController.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/07.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {

    var coordinator: AuthCoordinator?

    let signUpView = SignUpView()

    override func loadView() {
        view = signUpView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        signUpView.buttonSignUp.addTarget(self, action: #selector(didTapSignUpButton), for: .touchUpInside)
    }

    @objc func didTapSignUpButton() {
        if let email = signUpView.textFieldEmail.text, !email.isEmpty,
           let password = signUpView.textFieldPassword.text, !password.isEmpty {
            createUser(email: email, password: password)
        }
    }

    func createUser(email: String, password: String) {
        // Create a Firebase user with email and password
        Auth.auth().createUser(withEmail: email, password: password, completion: {result, error in
            if error == nil {
                // MARK: the user creation is successful

            } else {
                // MARK: there is an error creating the user
                print("Error occured: \(String(describing: error))")
            }
        })
    }

}
