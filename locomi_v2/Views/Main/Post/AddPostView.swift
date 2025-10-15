//
//  AddPostView.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/14.
//

import UIKit

class AddPostView: UIView {

    var labelPost: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white

        setupLabelAR()

        initConstraints()
    }

    func setupLabelAR() {
        labelPost = UILabel()
        labelPost.text = "Add Post"
        labelPost.font = UIFont.systemFont(ofSize: 30)
        labelPost.textAlignment = .center
        labelPost.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelPost)
    }

    func initConstraints() {
        NSLayoutConstraint.activate([
            labelPost.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            labelPost.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

