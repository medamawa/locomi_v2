//
//  AddPostViewController.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/14.
//

import UIKit

class AddPostViewController: UIViewController {

    var coordinator: Coordinator?

    let addPostView = AddPostView()

    override func loadView() {
        self.view = addPostView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancel))
    }

    @objc func didTapCancel() {
        dismiss(animated: true)
    }

}
