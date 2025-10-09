//
//  ViewController.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/08.
//

import UIKit

extension UIViewController {

    func showErrorAlert(title: String = "Error", message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }

}
