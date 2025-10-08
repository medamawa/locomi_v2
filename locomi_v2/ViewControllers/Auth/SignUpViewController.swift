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
    }

    @objc func didTapSignUpButton() {
        if let name = signUpView.textFieldName.text, !name.isEmpty,
           let email = signUpView.textFieldEmail.text, !email.isEmpty,
           let password = signUpView.textFieldPassword.text, !password.isEmpty {
            createUser(name: name, email: email, password: password)
        }
    }

}
