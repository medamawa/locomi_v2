//
//  MapViewController.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/07.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    var coordinator: MapCoordinator?

    let locationManager = LocationManager()

    var mapView = MapView()
    private var posts: [Post] = []

    override func loadView() {
        view = mapView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.mapView.delegate = self
        mapView.mapView.register(PostAnnotationView.self, forAnnotationViewWithReuseIdentifier: PostAnnotationView.reuseIdentifier)
        mapView.mapView.register(PostClusterAnnotationView.self, forAnnotationViewWithReuseIdentifier: PostClusterAnnotationView.reuseIdentifier)
        mapView.mapView.showsUserLocation = true
        locationManager.configure(presentingViewController: self)

        mapView.buttonAddPost.addTarget(self, action: #selector(didButtonAddPostTapped), for: .touchUpInside)
        mapView.buttonCurrentLocation.addTarget(self, action: #selector(didButtonCurrentLocationTapped), for: .touchUpInside)

        loadPosts()
        locationManager.fetchCurrentLocation { currentLocation in
            guard let currentLocation = currentLocation else {
                self.mapView.mapView.centerToLocation(location: CLLocation(latitude: 0, longitude: 0))
                return
            }

            self.mapView.mapView.centerToLocation(location: currentLocation)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    @objc func didButtonAddPostTapped() {
        locationManager.fetchCurrentLocation { currentLocation in
            guard let currentLocation else { return }
            
            self.coordinator?.showAddPost(at: currentLocation)
        }
    }

    @objc func didButtonCurrentLocationTapped() {

        locationManager.fetchCurrentLocation { currentLocation in
            guard let currentLocation = currentLocation else { return }

            self.mapView.mapView.centerToLocation(location: currentLocation)
        }
    }

    private func loadPosts() {

        FirestoreManager.shared.getAllPosts { posts, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.showErrorAlert(title: "Failed to fetch posts", message: error.localizedDescription)
                    return
                }

                guard let posts = posts else { return }

                self.displayPosts(posts)
            }
        }

    }

    func displayPosts(_ posts: [Post]) {
        self.posts = posts

        mapView.mapView.removeAnnotations(mapView.mapView.annotations)

        let annotations = posts.compactMap { PostAnnotation(post: $0) }
        mapView.mapView.addAnnotations(annotations)

    }

}

