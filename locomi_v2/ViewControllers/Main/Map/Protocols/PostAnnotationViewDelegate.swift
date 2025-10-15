//
//  PostAnnotationViewDelegate.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/14.
//

protocol PostAnnotationViewDelegate: AnyObject {

    func postAnnotationViewDidTapProfile(_ view: PostAnnotationView)

    func postAnnotationViewDidTapDetail(_ view: PostAnnotationView)

}
