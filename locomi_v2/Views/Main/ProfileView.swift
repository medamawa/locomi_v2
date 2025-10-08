//
//  ProfileView.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/07.
//

import UIKit

class ProfileView: UIView {

    var labelName: UILabel!
    var labelEmail: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground

        setupLabelName()
        setupLabelEmail()

        initConstraints()
    }

    func setupLabelName() {
        labelName = UILabel()
        labelName.text = "Sam Smith"
        labelName.font = .boldSystemFont(ofSize: 32)
        labelName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelName)
    }
    func setupLabelEmail() {
        labelEmail = UILabel()
        labelEmail.font = .systemFont(ofSize: 24)
        labelEmail.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelEmail)
    }

    func initConstraints() {
        NSLayoutConstraint.activate([
            labelName.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 64),
            labelName.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),

            labelEmail.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 12),
            labelEmail.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
