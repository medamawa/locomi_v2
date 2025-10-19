//
//  PostSheetVC+PageDelegate.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/17.
//

import UIKit

extension PostSheetViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let vc = viewController as? PostDetailViewController else { return nil }

        let prev = vc.index - 1
        guard prev >= 0 else { return nil }
        return detailVC(for: prev)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vc = viewController as? PostDetailViewController else { return nil }

        let next = vc.index + 1
        guard next < postsWithUsers.count else { return nil }
        return detailVC(for: next)
    }

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed,
           let currentVC = pageVC.viewControllers?.first as? PostDetailViewController {
            currentIndex = currentVC.index
            contentView.pageControl.currentPage = currentIndex
        }
    }

}
