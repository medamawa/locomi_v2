//
//  MainTabBarController.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/07.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let homeVC = HomeViewController()
        let profileVC = ProfileViewController()

        // setting tab bar items
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.circle"), tag: 1)

        viewControllers = [
            UINavigationController(rootViewController: homeVC),
            UINavigationController(rootViewController: profileVC)
        ]

        tabBar.tintColor = .systemBlue
        tabBar.isTranslucent = true
    }
    
}
