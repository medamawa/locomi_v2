//
//  ProfileCoordinator.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/08.
//

import UIKit

class ProfileCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    var childCoordinators = [Coordinator]()
    let navigationController: UINavigationController

    private let user: User?
    private let isRootProfile: Bool

    init() {
        self.navigationController = UINavigationController()
        self.navigationController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.circle"), tag: 2)

        self.user = nil
        self.isRootProfile = true
    }

    init(navigationController: UINavigationController, user: User) {
        self.navigationController = navigationController
        self.user = user
        self.isRootProfile = false
    }

    func start() {
        let profileVC: ProfileViewController

        if let user = self.user {
            profileVC = ProfileViewController(user: user)
        } else {
            profileVC = ProfileViewController()
        }
        profileVC.coordinator = self

        self.navigationController.pushViewController(profileVC, animated: true)
    }

    func showEditProfile(for user: User) {
        let editProfileVC = EditProfileViewController(user: user)
        editProfileVC.coordinator = self
        editProfileVC.delegate = self

        let nav = UINavigationController(rootViewController: editProfileVC)
        nav.modalTransitionStyle = .coverVertical
        navigationController.present(nav, animated: true)
    }
}

extension ProfileCoordinator: EditProfileViewControllerDelegate {
    func editProfileViewController(_ controller: EditProfileViewController, didUpdate user: User) {
        if let profileVC = navigationController.viewControllers.last as? ProfileViewController {
            profileVC.updateUser(user)
        }
    }

}
