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
    var buttonCurrentLocation: UIButton!
    var buttonAddPost: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground

        setupMapView()
        setupButtonCurrentLocation()
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
    func setupButtonCurrentLocation() {
        buttonCurrentLocation = UIButton(type: .system)

        let imageConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .semibold)
        buttonCurrentLocation.setImage(UIImage(systemName: "location.circle", withConfiguration: imageConfig), for: .normal)
        buttonCurrentLocation.backgroundColor = .systemBlue
        buttonCurrentLocation.tintColor = .white
        buttonCurrentLocation.layer.cornerRadius = 24

        buttonCurrentLocation.layer.shadowColor = UIColor.black.cgColor
        buttonCurrentLocation.layer.shadowOffset = CGSize(width: 0, height: 2)
        buttonCurrentLocation.layer.shadowRadius = 4
        buttonCurrentLocation.layer.shadowOpacity = 0.3

        buttonCurrentLocation.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(buttonCurrentLocation)
    }
    func setupButtonAddPost() {
        buttonAddPost = UIButton(type: .system)

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
            buttonAddPost.heightAnchor.constraint(equalToConstant: 56),

            buttonCurrentLocation.trailingAnchor.constraint(equalTo: buttonAddPost.trailingAnchor),
            buttonCurrentLocation.bottomAnchor.constraint(equalTo: buttonAddPost.topAnchor, constant: -16),
            buttonCurrentLocation.widthAnchor.constraint(equalTo: buttonAddPost.widthAnchor),
            buttonCurrentLocation.heightAnchor.constraint(equalTo: buttonAddPost.heightAnchor)

        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
