//
//  APICall.swift
//  WeatherApp
//
//  Created by Tom Golding on 10/5/2024.
//

import Foundation


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
