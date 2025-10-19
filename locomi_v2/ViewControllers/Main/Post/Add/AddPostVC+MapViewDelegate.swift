//
//  AddPostVC+MapViewDelegate.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/15.
//

import MapKit

extension AddPostViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: Self.reuseIdentifier)

        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: Self.reuseIdentifier)
            annotationView?.canShowCallout = true
            annotationView?.isDraggable = true
        } else {
            annotationView?.annotation = annotation
        }

        return annotationView
    }

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 didChange newState: MKAnnotationView.DragState, fromOldState oldState: MKAnnotationView.DragState) {

        guard newState == .ending else { return }

        guard let pin = view.annotation as? MKPointAnnotation else { return }

        let newCoordinate = pin.coordinate
        let mapPoint = MKMapPoint(newCoordinate)

        if !mapView.visibleMapRect.contains(mapPoint) {

            // TODO: make original annotation view and use setCoordinate method to use animation
            UIView.animate(withDuration: 0.3) {
                pin.coordinate = self.postCoordinate.coordinate
            }
            return
        }

        self.postCoordinate = self.postCoordinate.updateLocation(to: newCoordinate)

    }

}
