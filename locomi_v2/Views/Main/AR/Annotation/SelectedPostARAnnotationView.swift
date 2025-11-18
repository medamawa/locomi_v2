//
//  SelectedPostARAnnotationView.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/11/18.
//

extension PostARAnnotationView {

    func select() {
        imageViewProfile.layer.borderWidth = 3
    }

    func deselect() {
        imageViewProfile.layer.borderWidth = 1
    }
}
