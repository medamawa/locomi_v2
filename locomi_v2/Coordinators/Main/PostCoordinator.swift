//
//  PostCoordinator.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/20.
//

import UIKit
import MapKit

class PostCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    weak var postSheetDelegate: UIAdaptivePresentationControllerDelegate?

    init (navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() { }

    func showAddPost(at initialCoordinate: CLLocation) {
        let addPostVC = AddPostViewController()

        addPostVC.coordinator = self
        addPostVC.postCoordinate = initialCoordinate

        let nav = UINavigationController(rootViewController: addPostVC)
        nav.modalTransitionStyle = .coverVertical
        nav.modalPresentationStyle = .fullScreen
        navigationController.present(nav, animated: true)
    }

    func showPostSheet(of postsWithUsers: [PostWithUser], delegate: UIAdaptivePresentationControllerDelegate?) {
        let postSheetVC = PostSheetViewController(postsWithUsers: postsWithUsers)
        
        postSheetVC.coordinator = self
        postSheetVC.presentationController?.delegate = delegate
        self.postSheetDelegate = delegate

        navigationController.present(postSheetVC, animated: true)
    }

    func dismissPostSheet() {
        let presentedVC = navigationController.presentedViewController

        navigationController.dismiss(animated: true) { [weak self] in
            guard
                let self = self,
                let postSheetVC = presentedVC,
                let presentationController = postSheetVC.presentationController
            else { return }

            self.postSheetDelegate?.presentationControllerDidDismiss?(presentationController)
        }
    }

    func showProfile(for user: User) {
        let profileCoordinator = ProfileCoordinator(navigationController: navigationController, user: user)

        profileCoordinator.parentCoordinator = self
        childCoordinators.append(profileCoordinator)
        profileCoordinator.start()
    }

}
