//
//  ProfileView.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/07.
//

import UIKit

class ProfileView: UIView {

    var labelName: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground

        setupLabelName()

        initConstraints()
    }

    func setupLabelName() {
        labelName = UILabel()
        labelName.text = "Sam Smith"
        labelName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelName)
    }

    func initConstraints() {
        NSLayoutConstraint.activate([
            labelName.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            labelName.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
