//
//  MapViewDelegate.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/09.
//

import MapKit

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
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
         guard let postAnnotationView = view as? PostAnnotationView else { return }

         postAnnotationView.expand()
     }

     func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
         guard let postAnnotationView = view as? PostAnnotationView else { return }

         postAnnotationView.collapse()
     }
}
