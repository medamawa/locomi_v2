//
//  LocationManager.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/14.
//

import CoreLocation
import UIKit

final class LocationManager: NSObject, CLLocationManagerDelegate {

    private let manager = CLLocationManager()
    private weak var presentingViewController: UIViewController?

    private var singleUpdateCompletion: ((CLLocation?) -> Void)?
    var onLocationUpdate: ((CLLocation) -> Void)?
    var onAuthorizationDenied: (() -> Void)?

    private var isContinuousMode = false

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func configure(presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
    }

    // MARK: - One-time location fetch
    func fetchCurrentLocation(completion: @escaping (CLLocation?) -> Void) {
        singleUpdateCompletion = completion
        isContinuousMode = false
        checkAuthorizationAndRequestLocation()
    }

    // MARK: - Continuous location updates
    func startUpdatingLocation(onUpdate: @escaping (CLLocation) -> Void) {
        onLocationUpdate = onUpdate
        isContinuousMode = true
        checkAuthorizationAndRequestLocation()
    }

    func stopUpdatingLocation() {
        manager.stopUpdatingLocation()
        isContinuousMode = false
    }


    // MARK: - Authorization handling
    private func checkAuthorizationAndRequestLocation() {
        let status = manager.authorizationStatus

        switch status {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()

        case .denied, .restricted:
            showLocationAccessAlert()
            singleUpdateCompletion?(nil)
            singleUpdateCompletion = nil

        case .authorizedWhenInUse, .authorizedAlways:
            if isContinuousMode {
                manager.startUpdatingLocation()
            } else {
                manager.requestLocation()
            }

        @unknown default:
            singleUpdateCompletion?(nil)
            singleUpdateCompletion = nil
        }
    }

    // MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }

        if isContinuousMode {
            onLocationUpdate?(location)
        } else {
            singleUpdateCompletion?(location)
            singleUpdateCompletion = nil
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error: \(error.localizedDescription)")
        singleUpdateCompletion?(nil)
        singleUpdateCompletion = nil
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse ||
            manager.authorizationStatus == .authorizedAlways {
            if isContinuousMode {
                manager.startUpdatingLocation()
            } else {
                manager.requestLocation()
            }
        }
    }

    // MARK: - Alert
    private func showLocationAccessAlert() {
        guard let vc = presentingViewController else { return }

        let alert = UIAlertController(
            title: "Location Access Disabled",
            message: "To show your current location, please allow location access in Settings.",
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Open Settings", style: .default) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString),
               UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        })

        vc.present(alert, animated: true)
    }
}
