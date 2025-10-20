//
//  SelectedPostClusterAnnotationView.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/18.
//

extension PostClusterAnnotationView {

    func select() {
        isSelected = true
        imageViewProfile.layer.borderWidth = 3
    }

    func deselect() {
        isSelected = false
        imageViewProfile.layer.borderWidth = 1
    }
    
}
