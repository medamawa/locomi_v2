//
//  ARViewController.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/09.
//

import UIKit

class ARViewController: UIViewController {

    var coordinator: ARCoordinator?

    let arView = ARView()

    override func loadView() {
        self.view = arView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
