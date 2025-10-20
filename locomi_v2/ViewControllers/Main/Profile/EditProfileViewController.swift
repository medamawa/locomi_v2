//
//  EditProfileViewController.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/20.
//

import UIKit

class EditProfileViewController: UIViewController {

    let editProfileView = EditProfileView()

    private var user: User

    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        view = editProfileView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
