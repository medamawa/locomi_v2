//
//  PostSheetViewController.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/17.
//

import UIKit

class PostSheetViewController: UIViewController {

    let posts: [Post]
    let contentView = PostSheetView()

    var pageVC: UIPageViewController!
    var currentIndex = 0

    init(posts: [Post]) {
        self.posts = posts
        super.init(nibName: nil, bundle: nil)

        modalPresentationStyle = .pageSheet
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        setupPageViewController()
        setupSheet()
        setupPageControl()
    }

    func setupPageViewController() {
        pageVC = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        pageVC.dataSource = (posts.count > 1) ? self : nil
        pageVC.delegate = self

        let firstVC = detailVC(for: 0)
        pageVC.setViewControllers([firstVC], direction: .forward, animated: false)

        self.addChild(pageVC)
        contentView.pageContainerView.addSubview(pageVC.view)
        pageVC.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageVC.view.topAnchor.constraint(equalTo: contentView.pageContainerView.topAnchor),
            pageVC.view.leadingAnchor.constraint(equalTo: contentView.pageContainerView.leadingAnchor),
            pageVC.view.trailingAnchor.constraint(equalTo: contentView.pageContainerView.trailingAnchor),
            pageVC.view.bottomAnchor.constraint(equalTo: contentView.pageContainerView.bottomAnchor)
        ])
        pageVC.didMove(toParent: self)

        if let scrollView = pageVC.view.subviews.compactMap({ $0 as? UIScrollView }).first {
            scrollView.isScrollEnabled = (posts.count > 1)
        }
    }

    func setupSheet() {
        if let sheet = sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
        }
    }

    func setupPageControl() {
        contentView.pageControl.isHidden = (posts.count <= 1)
        contentView.pageControl.numberOfPages = posts.count
        contentView.pageControl.currentPage = 0
        contentView.pageControl.isUserInteractionEnabled = true
        contentView.pageControl.addTarget(self, action: #selector(pageControlChanged(_:)), for: .valueChanged)
    }

    @objc func pageControlChanged(_ sender: UIPageControl) {
        let newIndex = sender.currentPage
        guard newIndex != currentIndex else { return }

        let direction: UIPageViewController.NavigationDirection = newIndex > currentIndex ? .forward : .reverse
        let nextVC = detailVC(for: newIndex)

        pageVC.setViewControllers([nextVC], direction: direction, animated: true)

        currentIndex = newIndex
        contentView.pageControl.currentPage = newIndex
    }

    func detailVC(for index: Int) -> UIViewController {
        let vc = PostDetailViewController(post: posts[index])
        vc.index = index
        vc.totalCount = posts.count
        return vc
    }

}
