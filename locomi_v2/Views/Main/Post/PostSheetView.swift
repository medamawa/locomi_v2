//
//  PostSheetView.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/17.
//

import UIKit

class PostSheetView: UIView {

    var pageContainerView: UIView!
    var pageControl: UIPageControl!

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupPageContainerView()
        setupPageControl()

        initConstraints()
    }

    func setupPageContainerView() {
        pageContainerView = UIView()

        pageContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(pageContainerView)
    }
    func setupPageControl() {
        pageControl = UIPageControl()

        pageControl.pageIndicatorTintColor = .systemGray4
        pageControl.currentPageIndicatorTintColor = .label

        pageControl.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(pageControl)
    }

    func initConstraints() {
        NSLayoutConstraint.activate([
            pageContainerView.topAnchor.constraint(equalTo: topAnchor),
            pageContainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            pageContainerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            pageContainerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40),

            pageControl.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8),
            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
