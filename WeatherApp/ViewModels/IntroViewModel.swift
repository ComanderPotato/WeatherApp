//
//  IntroViewModel.swift
//  WeatherApp
//
//  Created by Leonna Myers on 11/5/2024.
//

// Current Location
// Current Location
import CoreLocation

class IntroViewModel: NSObject, CLLocationManagerDelegate, ObservableObject {
    var locationManager: CLLocationManager!
    @Published var currentCity: String = "Loading..."
    var error: Error?

    func onViewDidLoad() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            if CLLocationManager.locationServicesEnabled() {
                locationManager.startUpdatingLocation()
            }
        case .denied, .restricted, .notDetermined:
            print("Location services not authorised")
        @unknown default:
            fatalError("Unhandled case in location authorisation status")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                self.error = error
                return
            }
            
            if let placemark = placemarks?.first {
                if let city = placemark.locality {
                    self.currentCity = city
                } else if let suburb = placemark.subLocality {
                    self.currentCity = suburb
                } else {
                    self.currentCity = "Unknown"
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.error = error
    }
}
