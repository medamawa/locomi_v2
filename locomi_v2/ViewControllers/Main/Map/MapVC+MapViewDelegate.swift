//
//  MapVC+MapViewDelegate.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/09.
//

import MapKit

extension MapViewController: MKMapViewDelegate, UIAdaptivePresentationControllerDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        // For cluster annotation view
        if annotation is MKClusterAnnotation {
            var clusterAnnotationView  = mapView.dequeueReusableAnnotationView(
                withIdentifier: PostClusterAnnotationView.reuseIdentifier
            ) as? PostClusterAnnotationView

            if clusterAnnotationView == nil {
                clusterAnnotationView = PostClusterAnnotationView(
                    annotation: annotation,
                    reuseIdentifier: PostClusterAnnotationView.reuseIdentifier
                )
            } else {
                clusterAnnotationView?.annotation = annotation
            }

            // MARK: If use button in cluster view
            // clusterAnnotationView?.delegate = self
            return clusterAnnotationView
        }

        // For normal annotation view
         guard annotation is PostAnnotation else { return nil }

         var annotationView = mapView.dequeueReusableAnnotationView(
             withIdentifier: PostAnnotationView.reuseIdentifier
         ) as? PostAnnotationView

         if annotationView == nil {
             annotationView = PostAnnotationView(
                 annotation: annotation,
                 reuseIdentifier: PostAnnotationView.reuseIdentifier
             )
         } else {
             annotationView?.annotation = annotation
         }

        annotationView?.delegate = self
        return annotationView
     }

     func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {

         var postsWithUsers: [PostWithUser] = []

         if let postAnnotationView = view as? PostAnnotationView {
             postAnnotationView.select()

             guard let postAnnotation = postAnnotationView.annotation as? PostAnnotation else { return }

             postsWithUsers = [postAnnotation.postWithUser]
         } else if let clusterView = view as? PostClusterAnnotationView {
             clusterView.select()

             guard let cluster = clusterView.annotation as? MKClusterAnnotation else { return }
             postsWithUsers = cluster.memberAnnotations.compactMap {
                 ($0 as? PostAnnotation)?.postWithUser
             }
         } else {
             return
         }

         let sheetVC = PostSheetViewController(postsWithUsers: postsWithUsers)
         sheetVC.presentationController?.delegate = self
         present(sheetVC, animated: true)
     }

     func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
         if let postAnnotationView = view as? PostAnnotationView {
             postAnnotationView.deselect()
         } else if let clusterView = view as? PostClusterAnnotationView {
             clusterView.deselect()
         }
     }

    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        mapView.mapView.selectedAnnotations.forEach { annotation in
            mapView.mapView.deselectAnnotation(annotation, animated: true)
        }
    }
}
