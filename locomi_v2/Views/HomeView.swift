//
//  HomeView.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/07.
//

import UIKit

class HomeView: UIView {

    var labelHelloWorld: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground

        setupLabelHelloWorld()

        initConstraints()
    }

    func setupLabelHelloWorld() {
        labelHelloWorld = UILabel()
        labelHelloWorld.text = "Hello, World"
        labelHelloWorld.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelHelloWorld)
    }

    func initConstraints() {
        NSLayoutConstraint.activate([
            labelHelloWorld.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            labelHelloWorld.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
