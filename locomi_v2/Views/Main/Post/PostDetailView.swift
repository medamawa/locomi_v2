//
//  PostDetailView.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/17.
//

import UIKit

class PostDetailView: UIView {

    var labelTitle: UILabel!
    var labelContent: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLabelTitle()
        setupLabelContent()

        initConstraints()
    }

    func setupLabelTitle() {
        labelTitle = UILabel()

        labelTitle.text = "Post detail"

        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelTitle)
    }
    func setupLabelContent() {
        labelContent = UILabel()

        labelContent.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelContent)
    }

    func initConstraints() {
        NSLayoutConstraint.activate([
            labelTitle.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
            labelTitle.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),

            labelContent.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 16),
            labelContent.centerXAnchor.constraint(equalTo: labelTitle.centerXAnchor),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
