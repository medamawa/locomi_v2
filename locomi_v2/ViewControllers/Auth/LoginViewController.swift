//
//  LoginViewController.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/07.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    var coordinator: AuthCoordinator?

    var loginView = LoginView()

    override func loadView() {
        view = loginView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        loginView.buttonLogin.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        loginView.buttonSignUp.addTarget(self, action: #selector(didTapSignUpButton), for: .touchUpInside)

        // Dismiss keyboard when tap outside
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        loginView.addGestureRecognizer(tapGesture)
    }

    @objc func didTapLoginButton() {
        if let uwEmail = loginView.textFieldEmail.text, !uwEmail.isEmpty,
           let uwPassword = loginView.textFieldPassword.text, !uwPassword.isEmpty {
            signInToFireBase(email: uwEmail, password: uwPassword)
        }
    }

    @objc func didTapSignUpButton() {
        coordinator?.showSignUp()
    }

    func signInToFireBase(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password, completion: {(result, error) in
            if error == nil {
                // User authenticated
                self.coordinator?.didFinishAuth()

            } else {
                // TODO: Show alert
                print("Error occured: \(String(describing: error))")
            }
        })
    }

    @objc func dismissKeyboard() {
        loginView.endEditing(true)
    }

}
