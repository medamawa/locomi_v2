//
//  ProfileView.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/07.
//

import UIKit

class ProfileView: UIView {

    var imageViewProfile: UIImageView!
    var labelName: UILabel!
    var labelUsername: UILabel!
    var labelBio: UILabel!
    var stackViewStats: UIStackView!
    var labelPostsCount: UILabel!
    var labelFollowersCount: UILabel!
    var labelFollowingCount: UILabel!
    var buttonEditProfile: UIButton!
    var buttonLogout: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground

        setupImageViewProfile()
        setupLabelName()
        setupLabelUsername()
        setupLabelBio()
        setupStatsView()
        setupButtonEditProfile()
        setupButtonLogout()

        initConstraints()
    }

    func setupImageViewProfile() {
        imageViewProfile = UIImageView()

        imageViewProfile.image = UIImage(systemName: "person.circle.fill")
        imageViewProfile.contentMode = .scaleAspectFill
        imageViewProfile.clipsToBounds = true
        imageViewProfile.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        imageViewProfile.layer.cornerRadius = 50
        imageViewProfile.layer.borderWidth = 1

        imageViewProfile.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageViewProfile)
    }

    func setupLabelName() {
        labelName = UILabel()

        labelName.text = "..."
        labelName.font = .systemFont(ofSize: 24, weight: .bold)
        labelName.textAlignment = .center

        labelName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelName)
    }

    func setupLabelUsername() {
        labelUsername = UILabel()

        labelUsername.text = "@..."
        labelUsername.font = .systemFont(ofSize: 16)
        labelUsername.textColor = .systemGray
        labelUsername.textAlignment = .center

        labelUsername.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelUsername)
    }

    func setupLabelBio() {
        labelBio = UILabel()

        labelBio.text = "..."
        labelBio.font = .systemFont(ofSize: 15)
        labelBio.textAlignment = .center
        labelBio.numberOfLines = 0
        labelBio.textColor = .label

        labelBio.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelBio)
    }

    func setupStatsView() {
        let postsStack = createStatStack(count: "-", label: "Posts")
        labelPostsCount = postsStack.arrangedSubviews.first as? UILabel

        let followersStack = createStatStack(count: "-", label: "Followers")
        labelFollowersCount = followersStack.arrangedSubviews.first as? UILabel

        let followingStack = createStatStack(count: "-", label: "Following")
        labelFollowingCount = followingStack.arrangedSubviews.first as? UILabel

        stackViewStats = UIStackView(arrangedSubviews: [postsStack, followersStack, followingStack])
        stackViewStats.axis = .horizontal
        stackViewStats.distribution = .fillEqually
        stackViewStats.spacing = 20

        stackViewStats.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stackViewStats)
    }

    func createStatStack(count: String, label: String) -> UIStackView {
        let countLabel = UILabel()
        countLabel.text = count
        countLabel.font = .systemFont(ofSize: 20, weight: .bold)
        countLabel.textAlignment = .center

        let titleLabel = UILabel()
        titleLabel.text = label
        titleLabel.font = .systemFont(ofSize: 14)
        titleLabel.textColor = .systemGray
        titleLabel.textAlignment = .center

        let stack = UIStackView(arrangedSubviews: [countLabel, titleLabel])
        stack.axis = .vertical
        stack.spacing = 4

        return stack
    }

    func setupButtonEditProfile() {
        buttonEditProfile = UIButton(type: .system)

        buttonEditProfile.setTitle("Edit Profile", for: .normal)
        buttonEditProfile.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        buttonEditProfile.backgroundColor = .systemGray6
        buttonEditProfile.setTitleColor(.label, for: .normal)
        buttonEditProfile.layer.cornerRadius = 10

        buttonEditProfile.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonEditProfile)
    }

    func setupButtonLogout() {
        buttonLogout = UIButton(type: .system)

        buttonLogout.setTitle("Log Out", for: .normal)
        buttonLogout.titleLabel?.font = .systemFont(ofSize: 16)
        buttonLogout.setTitleColor(.systemRed, for: .normal)

        buttonLogout.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonLogout)
    }

    func initConstraints() {
        NSLayoutConstraint.activate([
            imageViewProfile.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
            imageViewProfile.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            imageViewProfile.widthAnchor.constraint(equalToConstant: 100),
            imageViewProfile.heightAnchor.constraint(equalToConstant: 100),

            labelName.topAnchor.constraint(equalTo: imageViewProfile.bottomAnchor, constant: 16),
            labelName.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            labelName.leadingAnchor.constraint(greaterThanOrEqualTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            labelName.trailingAnchor.constraint(lessThanOrEqualTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -24),

            labelUsername.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 4),
            labelUsername.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),

            labelBio.topAnchor.constraint(equalTo: labelUsername.bottomAnchor, constant: 12),
            labelBio.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            labelBio.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -24),

            stackViewStats.topAnchor.constraint(equalTo: labelBio.bottomAnchor, constant: 24),
            stackViewStats.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            stackViewStats.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -40),

            buttonEditProfile.topAnchor.constraint(equalTo: stackViewStats.bottomAnchor, constant: 24),
            buttonEditProfile.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            buttonEditProfile.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            buttonEditProfile.heightAnchor.constraint(equalToConstant: 44),

            buttonLogout.topAnchor.constraint(equalTo: buttonEditProfile.bottomAnchor, constant: 12),
            buttonLogout.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
