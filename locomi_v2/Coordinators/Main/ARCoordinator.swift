//
//  ARCoordinator.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/09.
//

import UIKit

class ARCoordinator: Coordinator {

    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init() {
        self.navigationController = UINavigationController()
        self.navigationController.tabBarItem = UITabBarItem(title: "AR", image: UIImage(systemName: "camera.viewfinder"), tag: 1)
    }

    func start() {
        let arVC = ARViewController()

        arVC.coordinator = self
        navigationController.setViewControllers([arVC], animated: true)
    }
}
