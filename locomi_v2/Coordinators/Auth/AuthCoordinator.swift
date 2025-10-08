//
//  AuthCoordinator.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/08.
//

import UIKit

class AuthCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var parentCoordinator: AppCoordinator?

    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        showLogin()
    }
    
    func showLogin() {
        let loginVC = LoginViewController()

        loginVC.coordinator = self
        navigationController.pushViewController(loginVC, animated: true)
    }

    func showSignUp() {
        let signUpVC = SignUpViewController()

        signUpVC.coordinator = self
        navigationController.pushViewController(signUpVC, animated: true)
    }

    func didFinishAuth() {
        parentCoordinator?.childCoordinators.removeAll()
    }
}

