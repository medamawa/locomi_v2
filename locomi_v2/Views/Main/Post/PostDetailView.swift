//
//  PostDetailView.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/17.
//

import UIKit

class PostDetailView: UIView {

    var imageProfile: UIImageView!
    var labelName: UILabel!
    var labelUsername: UILabel!
    var labelContent: UILabel!
    var labelCreatedAt: UILabel!
    var buttonComment: UIButton!
    var buttonLike: UIButton!
    var tableComments: UITableView!

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupImageProfile()
        setupLabelName()
        setupLabelUsername()
        setupLabelContent()
        setupLabelCreatedAt()
        setupButtons()
        setupTableView()

        initConstraints()
    }

    // MARK: - Setup UI
    private func setupImageProfile() {
        imageProfile = UIImageView()

        imageProfile.image = UIImage(systemName: "person.circle")
        imageProfile.contentMode = .scaleAspectFill
        imageProfile.clipsToBounds = true
        imageProfile.layer.cornerRadius = 24

        imageProfile.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageProfile)
    }

    private func setupLabelName() {
        labelName = UILabel()

        labelName.font = UIFont.boldSystemFont(ofSize: 16)
        labelName.text = "Display name"

        labelName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelName)
    }

    private func setupLabelUsername() {
        labelUsername = UILabel()

        labelUsername.font = UIFont.systemFont(ofSize: 14)
        labelUsername.textColor = .gray
        labelUsername.text = "@username"

        labelUsername.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelUsername)
    }

    private func setupLabelContent() {
        labelContent = UILabel()

        labelContent.font = UIFont.systemFont(ofSize: 15)
        labelContent.numberOfLines = 0
        labelContent.text = "sample content"

        labelContent.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelContent)
    }

    private func setupLabelCreatedAt() {
        labelCreatedAt = UILabel()

        labelCreatedAt.font = UIFont.systemFont(ofSize: 14)
        labelCreatedAt.textColor = .gray
        labelCreatedAt.text = "2h ago"

        labelCreatedAt.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelCreatedAt)
    }

    private func setupButtons() {
        buttonComment = UIButton(type: .system)

        buttonComment.setImage(UIImage(systemName: "ellipsis.message"), for: .normal)

        buttonComment.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonComment)

        buttonLike = UIButton(type: .system)

        buttonLike.setImage(UIImage(systemName: "hand.thumbsup"), for: .normal)

        buttonLike.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonLike)
    }

    private func setupTableView() {
        tableComments = UITableView()

        tableComments.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        tableComments.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableComments)
    }

    func initConstraints() {
        NSLayoutConstraint.activate([
            imageProfile.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            imageProfile.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            imageProfile.widthAnchor.constraint(equalToConstant: 48),
            imageProfile.heightAnchor.constraint(equalToConstant: 48),

            labelName.topAnchor.constraint(equalTo: imageProfile.topAnchor, constant: 4),
            labelName.leadingAnchor.constraint(equalTo: imageProfile.trailingAnchor, constant: 12),

            labelUsername.bottomAnchor.constraint(equalTo: imageProfile.bottomAnchor, constant: -4),
            labelUsername.leadingAnchor.constraint(equalTo: labelName.leadingAnchor),

            labelContent.topAnchor.constraint(equalTo: imageProfile.bottomAnchor, constant: 12),
            labelContent.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            labelContent.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),

            labelCreatedAt.topAnchor.constraint(equalTo: labelContent.bottomAnchor, constant: 8),
            labelCreatedAt.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),

            buttonComment.topAnchor.constraint(equalTo: labelCreatedAt.bottomAnchor, constant: 12),
            buttonComment.leadingAnchor.constraint(equalTo: labelContent.leadingAnchor, constant: 4),

            buttonLike.centerYAnchor.constraint(equalTo: buttonComment.centerYAnchor),
            buttonLike.leadingAnchor.constraint(equalTo: buttonComment.trailingAnchor, constant: 24),

            tableComments.topAnchor.constraint(equalTo: buttonComment.bottomAnchor, constant: 16),
            tableComments.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            tableComments.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            tableComments.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
