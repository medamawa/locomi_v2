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
        self.view.backgroundColor = .systemBackground

        loginView.buttonLogin.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        loginView.buttonSignUp.addTarget(self, action: #selector(didTapSignUpButton), for: .touchUpInside)

        // Dismiss keyboard when tap outside
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        loginView.addGestureRecognizer(tapGesture)

        // Enable/disable login button based on text fields have text or not
        loginView.textFieldEmail.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        loginView.textFieldPassword.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }

    @objc func didTapLoginButton() {
        guard let email = loginView.textFieldEmail.text?.trimmed,
              let password = loginView.textFieldPassword.text else {
            showErrorAlert(message: "Please fill in all required fields")
            return
        }

         if email.isBlank {
             showErrorAlert(message: "Email cannot be empty")
             return
         }

        if !email.isValidEmail {
            showErrorAlert(message: "Please enter a valid email address")
            return
        }

         if password.isBlank {
             showErrorAlert(message: "Password cannot be empty")
             return
         }

        if !password.isValidPassword {
            showErrorAlert(message: "Incorrect password")
            return
        }

        signInToFireBase(email: email, password: password)
    }

    @objc func didTapSignUpButton() {
        coordinator?.showSignUp()
    }

    @objc func textFieldDidChange() {
        let hasInput = !loginView.textFieldEmail.text!.isEmpty && !loginView.textFieldPassword.text!.isEmpty

        if (hasInput){
            loginView.buttonLogin.updateEnabledStateAnimated(isEnabled: true)
        } else {
            loginView.buttonLogin.updateEnabledStateAnimated(isEnabled: false)
        }
    }

    func signInToFireBase(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password, completion: {(result, error) in
            if error == nil {
                // User authenticated
                self.coordinator?.didFinishAuth()

            } else {
                let errorInfo = error!.firebaseAuthErrorInfo
                self.showErrorAlert(title: errorInfo.title, message: errorInfo.message)
            }
        })
    }

}
