//
//  ExpandedPostAnnotationView.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/14.
//

import UIKit

extension PostAnnotationView {

    func expand() {
        guard !isExpanded else { return }
        isExpanded = true

        imageButtonProfile.isEnabled = true
        expandedContainerView.isHidden = false
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0.5,
                       options: [.curveEaseInOut],
                       animations: {

            self.frame.size = CGSize(width: 240, height: 360)
            self.centerOffset = CGPoint(x: 0, y: -180)

            self.expandedContainerView.alpha = 1
            self.layoutIfNeeded()
        })
    }

    func collapse() {
        guard isExpanded else { return }
        isExpanded = false

        imageButtonProfile.isEnabled = false
        expandedContainerView.isHidden = true
        UIView.animate(withDuration: 0.3,
                       animations: {
            self.frame.size = CGSize(width: 60, height: 80)
            self.centerOffset = CGPoint(x: 0, y: -40)

            self.expandedContainerView.alpha = 1
            self.layoutIfNeeded()
        })
    }
}
