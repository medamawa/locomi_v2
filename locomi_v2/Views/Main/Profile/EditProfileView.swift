//
//  EditProfileView.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/20.
//

import UIKit

class EditProfileView: UIView {

    // MARK: - UI Elements
    var imageHeader: UIImageView!
    var imageProfile: UIImageView!
    var labelName: UILabel!
    var textFieldName: UITextField!
    var labelBio: UILabel!
    var textFieldBio: UITextField!

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupImageHeader()
        setupImageProfile()
        setupLabelName()
        setupTextFieldName()
        setupLabelBio()
        setupTextFieldBio()

        initConstraints()
    }

    func setupImageHeader() {
        imageHeader = UIImageView()

        imageHeader.backgroundColor = UIColor.systemGray5
        imageHeader.contentMode = .scaleAspectFill
        imageHeader.clipsToBounds = true

        imageHeader.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageHeader)
    }
    func setupImageProfile() {
        imageProfile = UIImageView()

        imageProfile.image = UIImage(systemName: "person.circle.fill")
        imageProfile.contentMode = .scaleAspectFill
        imageProfile.clipsToBounds = true
        imageProfile.backgroundColor = UIColor.systemGray5
        imageProfile.layer.cornerRadius = 50
        imageProfile.layer.borderWidth = 2
        imageProfile.layer.borderColor = UIColor.white.cgColor

        imageProfile.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageProfile)
    }
    func setupLabelName() {
        labelName = UILabel()

        labelName.text = "Name"
        labelName.font = UIFont.systemFont(ofSize: 16, weight: .medium)

        labelName.translatesAutoresizingMaskIntoConstraints = false
        addSubview(labelName)
    }
    func setupTextFieldName() {
        textFieldName = UITextField()

        textFieldName.placeholder = "Name"
        textFieldName.borderStyle = .roundedRect

        textFieldName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldName)
    }
    func setupLabelBio() {
        labelBio = UILabel()
        labelBio.text = "Bio"
        labelBio.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        labelBio.translatesAutoresizingMaskIntoConstraints = false
        addSubview(labelBio)
    }
    func setupTextFieldBio() {
        textFieldBio = UITextField()

        textFieldBio.placeholder = "Bio"
        textFieldBio.borderStyle = .roundedRect

        textFieldBio.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldBio)
    }

    func initConstraints() {
        NSLayoutConstraint.activate([
            // Header image
            imageHeader.topAnchor.constraint(equalTo: self.topAnchor),
            imageHeader.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageHeader.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageHeader.heightAnchor.constraint(equalToConstant: 160),

            // Profile image
            imageProfile.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            imageProfile.centerYAnchor.constraint(equalTo: imageHeader.bottomAnchor),
            imageProfile.widthAnchor.constraint(equalToConstant: 100),
            imageProfile.heightAnchor.constraint(equalToConstant: 100),

            // Name label & text field
            labelName.topAnchor.constraint(equalTo: imageProfile.bottomAnchor, constant: 32),
            labelName.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 24),
            labelName.widthAnchor.constraint(equalToConstant: 60),

            textFieldName.centerYAnchor.constraint(equalTo: labelName.centerYAnchor),
            textFieldName.leadingAnchor.constraint(equalTo: labelName.trailingAnchor, constant: 8),
            textFieldName.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -24),

            // Bio label & text field
            labelBio.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 20),
            labelBio.leadingAnchor.constraint(equalTo: labelName.leadingAnchor),
            labelBio.widthAnchor.constraint(equalToConstant: 60),

            textFieldBio.centerYAnchor.constraint(equalTo: labelBio.centerYAnchor),
            textFieldBio.leadingAnchor.constraint(equalTo: labelBio.trailingAnchor, constant: 8),
            textFieldBio.trailingAnchor.constraint(equalTo: textFieldName.trailingAnchor),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
