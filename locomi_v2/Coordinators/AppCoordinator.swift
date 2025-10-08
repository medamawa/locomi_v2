//
//  AppCoordinator.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/08.
//

import UIKit
import FirebaseAuth

class AppCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()

    private let window: UIWindow
    private let navigationController: UINavigationController
    private var authHandle: AuthStateDidChangeListenerHandle?

    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
    }

    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        setupAuthListener()
    }

    private func setupAuthListener() {
        authHandle = Auth.auth().addStateDidChangeListener({ auth, user in
            if user != nil {
                // the user is signed in
                self.showMainFlow()

            } else {
                // not signed in
                self.showAuthFlow()
            }
        })
    }

    private func showAuthFlow() {
        childCoordinators.removeAll()

        let authCoordinator = AuthCoordinator(navigationController: navigationController)
        authCoordinator.parentCoordinator = self
        childCoordinators.append(authCoordinator)

        UIView.transition(with: navigationController.view, duration: 0.3, options: .transitionCrossDissolve) {
            self.navigationController.viewControllers = []
            authCoordinator.start()
        }
    }

    private func showMainFlow() {
        childCoordinators.removeAll()

        let mainCoordinator = MainCoordinator(navigationController: navigationController)
        mainCoordinator.parentCoordinator = self
        childCoordinators.append(mainCoordinator)

        UIView.transition(with: navigationController.view, duration: 0.3, options: .transitionCrossDissolve) {
            self.navigationController.viewControllers = []
            mainCoordinator.start()
        }
    }

    deinit {
        if let handle = authHandle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
}
