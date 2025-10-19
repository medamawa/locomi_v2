//
//  SelectedPostAnnotationView.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/18.
//

extension PostAnnotationView {

    func select() {
        isSelected = true
        imageButtonProfile.layer.borderWidth = 3
    }

    func deselect() {
        isSelected = false
        imageButtonProfile.layer.borderWidth = 1
    }
}
