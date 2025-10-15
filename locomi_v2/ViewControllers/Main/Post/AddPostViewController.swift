//
//  AddPostViewController.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/14.
//

import UIKit
import MapKit

class AddPostViewController: UIViewController {

    var coordinator: Coordinator?

    static let reuseIdentifier = "PostPin"

    var postCoordinate: CLLocation!
    let addPostView = AddPostView()
    private var postPin = MKPointAnnotation()

    override func loadView() {
        self.view = addPostView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        addPostView.mapView.delegate = self
        addPostView.mapView.centerToLocation(location: postCoordinate, radius: 200)

        postPin.coordinate = postCoordinate.coordinate
        addPostView.mapView.addAnnotation(postPin)

        addPostView.textViewContent.delegate = self

        title = "New post"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancel))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Post", style: .plain, target: self, action: #selector(didTapPostButton))
        self.navigationItem.rightBarButtonItem?.isEnabled = false
    }

    @objc func didTapCancel() {
        dismiss(animated: true)
    }

    @objc func didTapPostButton() {
        print("post")
        dismiss(animated: true)
    }

}
