//
//  EditProfileView.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/20.
//

import UIKit

class EditProfileView: UIView {

    var labelSample: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLabelSample()

        initConstraints()
    }
    
    func setupLabelSample() {
        labelSample = UILabel()

        labelSample.text = "EditProfileView"

        labelSample.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelSample)
    }

    func initConstraints() {
        NSLayoutConstraint.activate([
            labelSample.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            labelSample.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
