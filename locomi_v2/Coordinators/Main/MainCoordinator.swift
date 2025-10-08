//
//  MainCoordinator.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/08.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var parentCoordinator: AppCoordinator?

    private let navigationController: UINavigationController
    private var tabBarController: MainTabBarController?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let tabBarController = MainTabBarController()
        self.tabBarController = tabBarController

        let homeCoordinator = HomeCoordinator()
        let profileCoordinator = ProfileCoordinator()

        childCoordinators = [
            homeCoordinator,
            profileCoordinator
        ]

        homeCoordinator.start()
        profileCoordinator.start()

        tabBarController.viewControllers = [
            homeCoordinator.navigationController,
            profileCoordinator.navigationController
        ]

        navigationController.setViewControllers([tabBarController], animated: true)
    }
}
