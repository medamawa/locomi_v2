//
//  ARView.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/09.
//

import UIKit

class ARView: UIView {

    var labelAR: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemTeal

        setupLabelAR()

        initConstraints()
    }

    func setupLabelAR() {
        labelAR = UILabel()
        labelAR.text = "AR Screen"
        labelAR.font = UIFont.systemFont(ofSize: 30)
        labelAR.textAlignment = .center
        labelAR.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelAR)
    }

    func initConstraints() {
        NSLayoutConstraint.activate([
            labelAR.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            labelAR.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
