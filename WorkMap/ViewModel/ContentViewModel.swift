//
//  ContentViewModel.swift
//  WorkMap
//
//  Created by Daniel Šuškevič on 2021-10-13.
//

import MapKit

enum MapDetails {
    static let startingLocation = CLLocationCoordinate2D(
        latitude: 54.711575,
        longitude: 25.261518)
    static let defaultSpan = MKCoordinateSpan(
        latitudeDelta: 0.005,
        longitudeDelta: 0.005)
}

final class ContentViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    // MARK: - PROPERTIES
    
    @Published var region = MKCoordinateRegion(center: MapDetails.startingLocation,
                                               span: MapDetails.defaultSpan) // currently displayed region
    @Published var locationsList = [
        Location(title: "Test Location 1", latitude: 54.711575, longitude: 25.261518),
        Location(title: "Test Location 2", latitude: 54.714981, longitude: 25.277554),
        Location(title: "Test Location 3", latitude: 54.668977, longitude: 25.237766),
        Location(title: "Test Location 4", latitude: 54.643023, longitude: 25.279469)]
    var locationManager: CLLocationManager?
    
    // MARK: - FUNCTIONS
    
    func showCurrentLocation() {
        guard let locationManager = locationManager else { return }
        guard let coordinate = locationManager.location?.coordinate else { return }
        region = MKCoordinateRegion(center: coordinate,
                                    span: MapDetails.defaultSpan)
    }
    
    func showLocation(_ location: Location) {
        region = MKCoordinateRegion(center: CLLocationCoordinate2D(
            latitude: location.latitude,
            longitude: location.longitude),
                                    span: MapDetails.defaultSpan)
    }
    
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
            break
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}
