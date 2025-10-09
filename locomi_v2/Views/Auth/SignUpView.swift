//
//  SignUpView.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/07.
//

import UIKit

class SignUpView: UIView {

    var scrollView: UIScrollView!
    var contentView: UIView!

    var labelTitle: UILabel!
    var textFieldDisplayName: UITextField!
    var textFieldUsername: UITextField!
    var textFieldEmail: UITextField!
    var textFieldPassword: UITextField!
    var textViewBio: UITextView!
    var labelBioPlaceholder: UILabel!
    var buttonSignUp: UIButton!


    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground

        setupScrollView()
        setupLabelTitle()
        setupTextFieldDisplayName()
        setupTextFieldUsername()
        setupTextFieldEmail()
        setupTextFieldPassword()
        setupTextViewBio()
        setupButtonSignUp()

        initConstraints()
    }

    func setupScrollView() {
        scrollView = UIScrollView()

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(scrollView)


        contentView = UIView()

        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
    }
    func setupLabelTitle() {
        labelTitle = UILabel()

        labelTitle.text = "Create Account"
        labelTitle.font = .systemFont(ofSize: 32, weight: .bold)
        labelTitle.textAlignment = .center

        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelTitle)
    }
    func setupTextFieldDisplayName() {
        textFieldDisplayName = UITextField()
        textFieldDisplayName.placeholder = "Name"
        textFieldDisplayName.font = .systemFont(ofSize: 16)
        textFieldDisplayName.borderStyle = .roundedRect

        textFieldDisplayName.textContentType = .name
        textFieldDisplayName.autocapitalizationType = .none
        textFieldDisplayName.autocorrectionType = .no
        textFieldDisplayName.returnKeyType = .next
        textFieldDisplayName.clearButtonMode = .whileEditing

        textFieldDisplayName.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(textFieldDisplayName)
    }
    func setupTextFieldUsername() {
        textFieldUsername = UITextField()
        textFieldUsername.placeholder = "Username (@username)"
        textFieldUsername.font = .systemFont(ofSize: 16)
        textFieldUsername.borderStyle = .roundedRect

        textFieldUsername.textContentType = .username
        textFieldUsername.autocapitalizationType = .none
        textFieldUsername.autocorrectionType = .no
        textFieldUsername.returnKeyType = .next
        textFieldUsername.clearButtonMode = .whileEditing

        textFieldUsername.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(textFieldUsername)
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
        contentView.addSubview(textFieldEmail)
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
        contentView.addSubview(textFieldPassword)
    }
    func setupTextViewBio() {
        textViewBio = UITextView()

        textViewBio.font = .systemFont(ofSize: 16)
        textViewBio.layer.borderColor = UIColor.systemGray4.cgColor
        textViewBio.layer.borderWidth = 1
        textViewBio.layer.cornerRadius = 8

        textViewBio.textContainerInset = UIEdgeInsets(top: 12, left: 8, bottom: 12, right: 8)
        textViewBio.isScrollEnabled = true

        textViewBio.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(textViewBio)


        labelBioPlaceholder = UILabel()

        labelBioPlaceholder.text = "Bio (optional)"
        labelBioPlaceholder.font = .systemFont(ofSize: 16)
        labelBioPlaceholder.textColor = .placeholderText

        labelBioPlaceholder.translatesAutoresizingMaskIntoConstraints = false
        textViewBio.addSubview(labelBioPlaceholder)
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
            // ScrollView constraints
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),

            // ContentView constraints
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            // Title
            labelTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 60),
            labelTitle.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            // Display Name
            textFieldDisplayName.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 40),
            textFieldDisplayName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            textFieldDisplayName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            textFieldDisplayName.heightAnchor.constraint(equalToConstant: 50),

            // Username
            textFieldUsername.topAnchor.constraint(equalTo: textFieldDisplayName.bottomAnchor, constant: 16),
            textFieldUsername.leadingAnchor.constraint(equalTo: textFieldDisplayName.leadingAnchor),
            textFieldUsername.trailingAnchor.constraint(equalTo: textFieldDisplayName.trailingAnchor),
            textFieldUsername.heightAnchor.constraint(equalToConstant: 50),

            // Email
            textFieldEmail.topAnchor.constraint(equalTo: textFieldUsername.bottomAnchor, constant: 16),
            textFieldEmail.leadingAnchor.constraint(equalTo: textFieldDisplayName.leadingAnchor),
            textFieldEmail.trailingAnchor.constraint(equalTo: textFieldDisplayName.trailingAnchor),
            textFieldEmail.heightAnchor.constraint(equalToConstant: 50),

            // Password
            textFieldPassword.topAnchor.constraint(equalTo: textFieldEmail.bottomAnchor, constant: 16),
            textFieldPassword.leadingAnchor.constraint(equalTo: textFieldDisplayName.leadingAnchor),
            textFieldPassword.trailingAnchor.constraint(equalTo: textFieldDisplayName.trailingAnchor),
            textFieldPassword.heightAnchor.constraint(equalToConstant: 50),

            // Bio TextView
            textViewBio.topAnchor.constraint(equalTo: textFieldPassword.bottomAnchor, constant: 16),
            textViewBio.leadingAnchor.constraint(equalTo: textFieldDisplayName.leadingAnchor),
            textViewBio.trailingAnchor.constraint(equalTo: textFieldDisplayName.trailingAnchor),
            textViewBio.heightAnchor.constraint(equalToConstant: 100),

            // Bio Placeholder
            labelBioPlaceholder.topAnchor.constraint(equalTo: textViewBio.topAnchor, constant: 12),
            labelBioPlaceholder.leadingAnchor.constraint(equalTo: textViewBio.leadingAnchor, constant: 12),

            // Sign Up Button
            buttonSignUp.topAnchor.constraint(equalTo: textViewBio.bottomAnchor, constant: 32),
            buttonSignUp.leadingAnchor.constraint(equalTo: textFieldDisplayName.leadingAnchor),
            buttonSignUp.trailingAnchor.constraint(equalTo: textFieldDisplayName.trailingAnchor),
            buttonSignUp.heightAnchor.constraint(equalToConstant: 50),
            buttonSignUp.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
