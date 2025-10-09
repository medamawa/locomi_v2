//
//  UIViewController+Keyboard.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/09.
//

import UIKit

extension UIViewController {

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

}
