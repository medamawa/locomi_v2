//
//  SignUpView.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/07.
//

import UIKit

class SignUpView: UIView {

    var labelTitle: UILabel!
    var textFieldName: UITextField!
    var textFieldEmail: UITextField!
    var textFieldPassword: UITextField!
    var buttonSignUp: UIButton!


    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground

        setupLabelTitle()
        setupTextFieldName()
        setupTextFieldEmail()
        setupTextFieldPassword()
        setupButtonSignUp()

        initConstraints()
    }

    func setupLabelTitle() {
        labelTitle = UILabel()

        labelTitle.text = "Create Account"
        labelTitle.font = .systemFont(ofSize: 32, weight: .bold)
        labelTitle.textAlignment = .center

        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelTitle)
    }
    func setupTextFieldName() {
        textFieldName = UITextField()
        textFieldName.placeholder = "Name"
        textFieldName.font = .systemFont(ofSize: 16)
        textFieldName.borderStyle = .roundedRect

        textFieldName.textContentType = .name
        textFieldName.autocapitalizationType = .words
        textFieldName.autocorrectionType = .no
        textFieldName.returnKeyType = .next
        textFieldName.clearButtonMode = .whileEditing

        textFieldName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldName)
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

        textFieldPassword.textContentType = .newPassword
        textFieldPassword.isSecureTextEntry = true
        textFieldPassword.returnKeyType = .done
        textFieldPassword.clearButtonMode = .whileEditing

        textFieldPassword.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldPassword)
    }
    func setupButtonSignUp() {
        buttonSignUp = UIButton(type: .system)

        buttonSignUp.setTitle("Sign up", for: .normal)
        buttonSignUp.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        buttonSignUp.backgroundColor = .systemBlue
        buttonSignUp.setTitleColor(.white, for: .normal)
        buttonSignUp.layer.cornerRadius = 12

        buttonSignUp.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonSignUp)
    }

    func initConstraints() {
        NSLayoutConstraint.activate([
            labelTitle.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 80),
            labelTitle.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),

            textFieldName.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 60),
            textFieldName.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            textFieldName.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            textFieldName.heightAnchor.constraint(equalToConstant: 50),

            textFieldEmail.topAnchor.constraint(equalTo: textFieldName.bottomAnchor, constant: 16),
            textFieldEmail.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            textFieldEmail.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            textFieldEmail.heightAnchor.constraint(equalToConstant: 50),

            textFieldPassword.topAnchor.constraint(equalTo: textFieldEmail.bottomAnchor, constant: 16),
            textFieldPassword.leadingAnchor.constraint(equalTo: textFieldEmail.leadingAnchor),
            textFieldPassword.trailingAnchor.constraint(equalTo: textFieldEmail.trailingAnchor),
            textFieldPassword.heightAnchor.constraint(equalToConstant: 50),

            buttonSignUp.topAnchor.constraint(equalTo: textFieldPassword.bottomAnchor, constant: 32),
            buttonSignUp.leadingAnchor.constraint(equalTo: textFieldEmail.leadingAnchor),
            buttonSignUp.trailingAnchor.constraint(equalTo: textFieldEmail.trailingAnchor),
            buttonSignUp.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
