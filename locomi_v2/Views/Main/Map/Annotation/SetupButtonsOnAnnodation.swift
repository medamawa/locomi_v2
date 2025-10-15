//
//  SetupButtonsOnAnnotation.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/14.
//

import UIKit

extension PostAnnotationView {

    func setupButtons() {
        imageButtonProfile.addTarget(self, action: #selector(didProfileTapped), for: .touchUpInside)
        buttonDetail.addTarget(self, action: #selector(didDetailTapped), for: .touchUpInside)
    }

    @objc func didProfileTapped() {
        delegate?.postAnnotationViewDidTapProfile(self)
    }

    @objc func didDetailTapped() {
        delegate?.postAnnotationViewDidTapDetail(self)
    }
}

