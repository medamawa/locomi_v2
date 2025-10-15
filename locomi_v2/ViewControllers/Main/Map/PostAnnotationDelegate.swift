//
//  PostAnnotationDelegate.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/14.
//

import UIKit

extension MapViewController: PostAnnotationViewDelegate {

    func postAnnotationViewDidTapProfile(_ view: PostAnnotationView) {
        guard let postAnnotation = view.annotation as? PostAnnotation else { return }

        print("\(postAnnotation.title)'s profile is tapped")
    }

    func postAnnotationViewDidTapDetail(_ view: PostAnnotationView) {
        guard let postAnnotation = view.annotation as? PostAnnotation else { return }

        print("\(postAnnotation.title)'s detail is tapped")
    }


}
