//
//  SignUpViewController.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/07.
//

import UIKit

class SignUpViewController: UIViewController {

    var coordinator: AuthCoordinator?

    let signUpView = SignUpView()

    override func loadView() {
        view = signUpView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        signUpView.buttonSignUp.addTarget(self, action: #selector(didTapSignUpButton), for: .touchUpInside)

        // Observe keyboard status
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        // Dismiss keyboard when tap outside
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        signUpView.addGestureRecognizer(tapGesture)
    }

    @objc func didTapSignUpButton() {
        guard let displayName = signUpView.textFieldDisplayName.text?.trimmed,
              let username = signUpView.textFieldUsername.text?.trimmed,
              let email = signUpView.textFieldEmail.text?.trimmed,
              let password = signUpView.textFieldPassword.text,
              let bio = signUpView.textViewBio.text else {
            showErrorAlert(message: "Please fill in all required fields")
            return
        }

        if displayName.isBlank {
             showErrorAlert(message: "Display name cannot be empty")
             return
         }
        
         if username.isBlank {
             showErrorAlert(message: "Username cannot be empty")
             return
         }

        if !username.isValidUsername {
            showErrorAlert(message: "Username must be at least 3 characters and contain only letters, numbers, and underscores")
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
            showErrorAlert(message: "PPassword must be at least 8 characters long and contain uppercase letters, lowercase letters, and numbers")
            return
        }

        createUser(displayName: displayName, username: username, email: email, password: password, bio: bio)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height, right: 0)
        signUpView.scrollView.contentInset = contentInsets
        signUpView.scrollView.scrollIndicatorInsets = contentInsets
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        signUpView.scrollView.contentInset = .zero
        signUpView.scrollView.scrollIndicatorInsets = .zero
    }

    @objc func dismissKeyboard() {
        signUpView.endEditing(true)
    }

}
