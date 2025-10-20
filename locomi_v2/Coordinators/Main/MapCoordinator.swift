//
//  MapCoordinator.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/08.
//

import UIKit
import MapKit

class MapCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    let navigationController: UINavigationController

    init() {
        self.navigationController = UINavigationController()
        self.navigationController.tabBarItem = UITabBarItem(title: "Map", image: UIImage(systemName: "mappin.and.ellipse"), tag: 0)
    }

    func start() {
        let mapVC = MapViewController()

        mapVC.coordinator = self
        navigationController.pushViewController(mapVC, animated: true)
    }

    func showAddPost(at initialCoordinate: CLLocation) {
        let postCoordinator = PostCoordinator(navigationController: navigationController)

        postCoordinator.parentCoordinator = self
        childCoordinators.append(postCoordinator)

        postCoordinator.showAddPost(at: initialCoordinate)
    }

    func showPostSheet(of postsWithUsers: [PostWithUser], delegate: UIAdaptivePresentationControllerDelegate?) {
        let postCoordinator = PostCoordinator(navigationController: navigationController)
        
        postCoordinator.parentCoordinator = self
        childCoordinators.append(postCoordinator)

        postCoordinator.showPostSheet(of: postsWithUsers, delegate: delegate)
    }
}
