//
//  IntroViewModel.swift
//  WeatherApp
//
//  Created by Leonna Myers on 11/5/2024.
//

// Current Location

import CoreLocation

class IntroViewModel: NSObject, CLLocationManagerDelegate {
    var locationManager: CLLocationManager!
    var currentCity: String = ""
    var error: Error?

    func onViewDidLoad() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
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
