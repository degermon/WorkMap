//
//  ContentViewModel.swift
//  WorkMap
//
//  Created by Daniel Šuškevič on 2021-10-13.
//

import Foundation
import MapKit

final class ContentViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    // MARK: - PROPERTIES
    
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(
        latitude: 54.73029277914454,
        longitude: 25.269726488523315),
    span: MKCoordinateSpan(
        latitudeDelta: 0.005,
        longitudeDelta: 0.005))
    
    var locationManager: CLLocationManager?
    
    // MARK: - FUNCTIONS
    
    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
        } else {
            print("Show alert notifying it is off.")
        }
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Your location is restricted likely due to parental controls.")
        case .denied:
            print("You have denied this app location services, please enable it in settings.")
        case .authorizedAlways, .authorizedWhenInUse:
            guard let coordinate = locationManager.location?.coordinate else { break }
            region = MKCoordinateRegion(center: coordinate,
                                        span: MKCoordinateSpan(
                latitudeDelta: 0.005,
                longitudeDelta: 0.005))
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    private func transformCoordinatesToCoordinateRegion(coordinates: Location) -> MKCoordinateRegion {
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude),
        span: MKCoordinateSpan(
            latitudeDelta: 0.005,
            longitudeDelta: 0.005))
                                        
        return region
    }
}
