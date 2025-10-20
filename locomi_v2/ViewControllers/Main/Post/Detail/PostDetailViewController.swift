//
//  PostDetailViewController.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/17.
//

import UIKit

class PostDetailViewController: UIViewController {

    var postWithUser: PostWithUser
    var index = 0
    var totalCount = 1

    let postDetailView = PostDetailView()

    init(postWithUser: PostWithUser) {
        self.postWithUser = postWithUser
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = postDetailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        setupPostDetailView()
    }

    func setupPostDetailView() {
        postDetailView.labelName.text = postWithUser.user?.displayName
        postDetailView.labelUsername.text = postWithUser.user?.username
        postDetailView.labelContent.text = postWithUser.post.content

        let date = postWithUser.post.createdAt

        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.locale = Locale(identifier: "en_US")

        postDetailView.labelCreatedAt.text = formatter.string(from: date)
    }
}
