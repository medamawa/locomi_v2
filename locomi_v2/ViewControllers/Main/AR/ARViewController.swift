//
//  ARViewController.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/09.
//

import UIKit
import ARKit
import SceneKit
import CoreLocation
import MapKit

class ARViewController: UIViewController {

    var coordinator: ARCoordinator?

    var sceneLocationView = SceneLocationView()

    private var postsWithUsers: [PostWithUser] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.sceneLocationView.locationNodeTouchDelegate = self
        view.addSubview(sceneLocationView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        sceneLocationView.frame = view.bounds
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        sceneLocationView.run()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        loadPostsWithUsers()
    }

    private func loadPostsWithUsers() {

        FirestoreManager.shared.postService.getAllPostsWithUsers { postsWithUsers, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.showErrorAlert(title: "Failed to fetch posts", message: error.localizedDescription)
                    return
                }

                guard let postsWithUsers = postsWithUsers else { return }

                self.displayPosts(postsWithUsers)
            }
        }

    }

    private func displayPosts(_ postsWithUsers: [PostWithUser]) {
        self.postsWithUsers = postsWithUsers

        for postWithUser in postsWithUsers {
            let coordinate = postWithUser.post.coordinate
            guard let altitude = postWithUser.post.altitude else { continue }
            let location = CLLocation(coordinate: coordinate, altitude: altitude)

            let node = LocationAnnotationNode(location: location, view: PostARAnnotationView(postWithUser: postWithUser))
//            node.scaleRelativeToDistance = true
            node.scale = SCNVector3(4.0, 4.0, 4.0)
            sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode: node)

            print("Added on AR: " + postWithUser.post.content)
        }
    }

}

extension ARViewController: LNTouchDelegate {

    func annotationNodeTouched(node: AnnotationNode) {
        if let nodeView = node.view {

            if let postView = nodeView as? PostARAnnotationView {
                postView.select()
                print("Touched post: \(postView.labelContent.text)")
            }
        }
    }

    func locationNodeTouched(node: LocationNode) {
        print("Touched location")
    }

}
