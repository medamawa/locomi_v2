//
//  LoginView.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/07.
//

import UIKit

class LoginView: UIView {

    var labelTitle: UILabel!
    var textFieldEmail: UITextField!
    var textFieldPassword: UITextField!
    var buttonLogin: UIButton!
    var buttonSignUp: UIButton!


    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground

        setupLabelTitle()
        setupTextFieldEmail()
        setupTextFieldPassword()
        setupButtonLogin()
        setupButtonSignUp()

        initConstraints()
    }

    func setupLabelTitle() {
        labelTitle = UILabel()

        labelTitle.text = "Welcome Back"
        labelTitle.font = .systemFont(ofSize: 32, weight: .bold)
        labelTitle.textAlignment = .center

        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelTitle)
    }
    func setupTextFieldEmail() {
        textFieldEmail = UITextField()

        textFieldEmail.placeholder = "Email"
        textFieldEmail.font = .systemFont(ofSize: 16)
        textFieldEmail.borderStyle = .roundedRect

        textFieldEmail.textContentType = .emailAddress
        textFieldEmail.keyboardType = .emailAddress
        textFieldEmail.autocapitalizationType = .none
        textFieldEmail.autocorrectionType = .no
        textFieldEmail.returnKeyType = .next
        textFieldEmail.clearButtonMode = .whileEditing

        textFieldEmail.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldEmail)
    }
    func setupTextFieldPassword() {
        textFieldPassword = UITextField()

        textFieldPassword.placeholder = "Password"
        textFieldPassword.font = .systemFont(ofSize: 16)
        textFieldPassword.borderStyle = .roundedRect

        textFieldPassword.textContentType = .password
        textFieldPassword.isSecureTextEntry = true
        textFieldPassword.returnKeyType = .done
        textFieldPassword.clearButtonMode = .whileEditing

        textFieldPassword.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldPassword)
    }
    func setupButtonLogin() {
        buttonLogin = UIButton(type: .system)

        buttonLogin.setTitle("Log in", for: .normal)
        buttonLogin.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        buttonLogin.backgroundColor = .systemBlue
        buttonLogin.setTitleColor(.white, for: .normal)
        buttonLogin.layer.cornerRadius = 12

        buttonLogin.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonLogin)
    }
    func setupButtonSignUp() {
        buttonSignUp = UIButton(type: .system)

        buttonSignUp.setTitle("Don't have an account? Sign Up", for: .normal)
        buttonSignUp.titleLabel?.font = .systemFont(ofSize: 15)

        buttonSignUp.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonSignUp)
    }

    func initConstraints() {
        NSLayoutConstraint.activate([
            labelTitle.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 80),
            labelTitle.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),

            textFieldEmail.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 60),
            textFieldEmail.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            textFieldEmail.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            textFieldEmail.heightAnchor.constraint(equalToConstant: 50),

            textFieldPassword.topAnchor.constraint(equalTo: textFieldEmail.bottomAnchor, constant: 16),
            textFieldPassword.leadingAnchor.constraint(equalTo: textFieldEmail.leadingAnchor),
            textFieldPassword.trailingAnchor.constraint(equalTo: textFieldEmail.trailingAnchor),
            textFieldPassword.heightAnchor.constraint(equalToConstant: 50),

            buttonLogin.topAnchor.constraint(equalTo: textFieldPassword.bottomAnchor, constant: 32),
            buttonLogin.leadingAnchor.constraint(equalTo: textFieldEmail.leadingAnchor),
            buttonLogin.trailingAnchor.constraint(equalTo: textFieldEmail.trailingAnchor),
            buttonLogin.heightAnchor.constraint(equalToConstant: 50),

            buttonSignUp.topAnchor.constraint(equalTo: buttonLogin.bottomAnchor, constant: 20),
            buttonSignUp.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
