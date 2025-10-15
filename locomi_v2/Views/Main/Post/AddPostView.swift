//
//  AddPostView.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/14.
//

import UIKit
import MapKit

class AddPostView: UIView {

    var scrollView: UIScrollView!
    var mapView: MKMapView!
    var textViewContent: UITextView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white

        setupScrollView()
        setupMapView()
        setupTextViewContent()

        initConstraints()
    }

    func setupScrollView() {
        scrollView = UIScrollView()

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(scrollView)
    }
    func setupMapView() {
        mapView = MKMapView()

        mapView.isScrollEnabled = false
        mapView.isZoomEnabled = false
        mapView.isRotateEnabled = false
        mapView.isPitchEnabled = false

        mapView.layer.cornerRadius = 20
        mapView.clipsToBounds = true

        mapView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(mapView)
    }
    func setupTextViewContent() {
        textViewContent = UITextView()

        textViewContent.font = .systemFont(ofSize: 16)
        textViewContent.layer.borderColor = UIColor.systemGray4.cgColor
        textViewContent.layer.borderWidth = 1
        textViewContent.layer.cornerRadius = 8

        textViewContent.textContainerInset = UIEdgeInsets(top: 12, left: 8, bottom: 12, right: 8)
        textViewContent.isScrollEnabled = true
        
        textViewContent.autocapitalizationType = .none
        textViewContent.autocorrectionType = .no
        textViewContent.spellCheckingType = .no

        textViewContent.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(textViewContent)
    }

    func initConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            scrollView.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor),
            scrollView.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor),

            mapView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            mapView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            mapView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            mapView.heightAnchor.constraint(equalToConstant: 240),
            mapView.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, constant: -32),

            textViewContent.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 16),
            textViewContent.leadingAnchor.constraint(equalTo: mapView.leadingAnchor),
            textViewContent.trailingAnchor.constraint(equalTo: mapView.trailingAnchor),
            textViewContent.heightAnchor.constraint(equalToConstant: 240),

            textViewContent.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

