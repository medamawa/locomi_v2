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
        if let displayName = signUpView.textFieldDisplayName.text, !displayName.isEmpty,
           let username = signUpView.textFieldUsername.text, !displayName.isEmpty,
           let email = signUpView.textFieldEmail.text, !email.isEmpty,
           let password = signUpView.textFieldPassword.text, !password.isEmpty,
           let bio = signUpView.textViewBio.text {
            createUser(displayName: displayName, username: username, email: email, password: password, bio: bio)
        }
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
