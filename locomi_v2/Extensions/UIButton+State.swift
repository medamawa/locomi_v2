//
//  UIButton+State.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/09.
//

import UIKit

extension UIButton {

    func updateEnabledStateAnimated(isEnabled: Bool) {
        self.isEnabled = isEnabled

        UIView.animate(withDuration: 0.3) {
            if isEnabled {
                self.backgroundColor = .systemBlue
                self.alpha = 1.0
            } else {
                self.backgroundColor = .systemGray2
                self.alpha = 0.5
            }
        }
    }
}
