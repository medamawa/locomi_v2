//
//  ProfileCoordinator.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/08.
//

import UIKit

class ProfileCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init() {
        self.navigationController = UINavigationController()
        self.navigationController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.circle"), tag: 2)
    }

    func start() {
        let profileVC = ProfileViewController()
        
        profileVC.coordinator = self
        navigationController.setViewControllers([profileVC], animated: true)
    }
}
