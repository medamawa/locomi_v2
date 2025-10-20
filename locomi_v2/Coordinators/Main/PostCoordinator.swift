//
//  PostCoordinator.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/20.
//

import UIKit

class PostCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init (navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {  }

    func showPostSheet(of postsWithUsers: [PostWithUser], delegate: UIAdaptivePresentationControllerDelegate?) {
        let postSheetVC = PostSheetViewController(postsWithUsers: postsWithUsers)
        
        postSheetVC.coordinator = self
        postSheetVC.presentationController?.delegate = delegate

        navigationController.present(postSheetVC, animated: true)
    }

    func showProfile(for user: User) {
        let profileCoordinator = ProfileCoordinator(navigationController: navigationController, user: user)

        profileCoordinator.parentCoordinator = self
        childCoordinators.append(profileCoordinator)
        profileCoordinator.start()
    }
}
