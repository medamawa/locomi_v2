//
//  MainCoordinator.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/08.
//

import UIKit

class MainCoordinator: Coordinator {
    var parentCoordinator: AppCoordinator?
    var childCoordinators = [Coordinator]()
    let navigationController: UINavigationController

    private var tabBarController: MainTabBarController?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let tabBarController = MainTabBarController()
        self.tabBarController = tabBarController

        let mapCoordinator = MapCoordinator()
        let arCoordinator = ARCoordinator()
        let profileCoordinator = ProfileCoordinator()

        childCoordinators = [
            mapCoordinator,
            arCoordinator,
            profileCoordinator
        ]

        mapCoordinator.start()
        arCoordinator.start()
        profileCoordinator.start()

        tabBarController.viewControllers = [
            mapCoordinator.navigationController,
            arCoordinator.navigationController,
            profileCoordinator.navigationController
        ]

        navigationController.setViewControllers([tabBarController], animated: true)
    }
}
