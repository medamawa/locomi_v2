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

    var mapView = MapView()
    private var posts: [Post] = []

    override func loadView() {
        view = mapView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.mapView.delegate = self

        loadPosts()
    }



    private func loadPosts() {

        // TODO: load posts from firestore
        let samplePosts = [
            Post(uid: "user1", content: "beautiful", latitude: 35.6812, longitute: 139.7671, locationName: "Tokyo station"),
            Post(uid: "user2", content: "nice cafe, tatte", latitude: 35.6586, longitute: 139.7454, locationName: "Tokyo tower")
        ]

        displayPosts(samplePosts)
    }

    func displayPosts(_ posts: [Post]) {
        self.posts = posts

        mapView.mapView.removeAnnotations(mapView.mapView.annotations)

        let annotations = posts.compactMap { PostAnnotation(post: $0) }
        mapView.mapView.addAnnotations(annotations)

        // adjust map range
        if let firstPost = posts.first {
            let region = MKCoordinateRegion(
                center: firstPost.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
            mapView.mapView.setRegion(region, animated: true)
        }
    }


}

