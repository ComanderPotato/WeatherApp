//
//  LocationViewModel.swift
//  WeatherApp
//
//  Created by Tom Golding on 10/5/2024.
//

import Foundation

class LocationViewModel: ObservableObject {
    init() {}
    
    func getForecastData<T: Codable>(location: String, days: String) async throws -> T {
        return try await apiCall(request: APIRequest.forecast, location: location, days: days)
    }
    
}
