//
//  MapView.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/07.
//

import UIKit
import MapKit

class MapView: UIView {

    var mapView: MKMapView!
    var buttonAddPost: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground

        setupMapView()
        setupButtonAddPost()

        initConstraints()
    }

    func setupMapView() {
        mapView = MKMapView()

        mapView.showsCompass = true
        mapView.showsScale = true
        mapView.showsBuildings = true
        mapView.isRotateEnabled = true
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.isPitchEnabled = true

        mapView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(mapView)
    }
    func setupButtonAddPost() {
        buttonAddPost = UIButton()

        let imageConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .semibold)
        buttonAddPost.setImage(UIImage(systemName: "plus", withConfiguration: imageConfig), for: .normal)
        buttonAddPost.backgroundColor = .systemBlue
        buttonAddPost.tintColor = .white
        buttonAddPost.layer.cornerRadius = 24

        buttonAddPost.layer.shadowColor = UIColor.black.cgColor
        buttonAddPost.layer.shadowOffset = CGSize(width: 0, height: 2)
        buttonAddPost.layer.shadowRadius = 4
        buttonAddPost.layer.shadowOpacity = 0.3

        buttonAddPost.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonAddPost)
    }

    func initConstraints() {
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: self.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: self.trailingAnchor),

            buttonAddPost.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            buttonAddPost.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            buttonAddPost.widthAnchor.constraint(equalToConstant: 56),
            buttonAddPost.heightAnchor.constraint(equalToConstant: 56)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
