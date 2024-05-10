//
//  APICalls.swift
//  WeatherApp
//
//  Created by Tom Golding on 9/5/2024.
//

import Foundation

// Refactor into seperate file
let API_KEY = "78f67b17b64a41acbbb22331240905"
enum GHError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case bad
}
enum APIRequest: String {
    case current = "current"
    case forecast = "forecast"
    case search = "search"
}
class APICalls: ObservableObject {
    init() {
    }
    func getWeatherData<T: Codable>(location: String) async throws -> T {
        return try await apiCall(request: APIRequest.current, location: location)
    }
    func searchQuery<T: Codable>(searchQuery: String) async throws -> T {
        return try await apiCall(request: APIRequest.search, location: searchQuery)
    }
    func getForecastData<T: Codable>(location: String, days: String) async throws -> T {
        return try await apiCall(request: APIRequest.forecast, location: location, days: days)
    }
    
    func apiCall<T: Codable>(request: APIRequest, location: String, days: String? = "") async throws -> T {
        let endPoint = "https://api.weatherapi.com/v1/\(request.rawValue).json?key=\(API_KEY)&q=\(location)\(days != "" ? "&days=\(days!)" : "")"
        guard let url = URL(string: endPoint) else {
            throw GHError.invalidURL
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GHError.invalidResponse
        }
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            throw GHError.invalidData
        }
    }
}
