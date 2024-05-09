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
// Will refactor just putting scaffold down
class APICalls: ObservableObject {
    init() {
        
    }
    
    func getWeatherData(location: String) async throws -> WeatherData {
        let endPoint = "https://api.weatherapi.com/v1/current.json?key=\(API_KEY)&q=\(location)"
        guard let url = URL(string: endPoint) else {
            throw GHError.invalidURL
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GHError.invalidResponse
        }
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(WeatherData.self, from: data)
        } catch {
            throw GHError.invalidData
        }
    }
    
    
    func searchQuery(query: String) async throws -> [Location] {
        let endPoint = "https://api.weatherapi.com/v1/search.json?key=\(API_KEY)&q=\(query)"
        guard let url = URL(string: endPoint) else {
            throw GHError.invalidURL
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        
        print(data)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GHError.invalidResponse
        }
        do {
            let decoder = JSONDecoder()
            return try decoder.decode([Location].self, from: data)
        } catch {
            throw GHError.invalidData
        }
    }
    
    func getForecast(location: String) async throws -> Forecast {
        let endPoint = "https://api.weatherapi.com/v1/forecast.json?key=\(API_KEY)&q=\(location)"
        guard let url = URL(string: endPoint) else {
            throw GHError.invalidURL
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        
        print(data)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GHError.invalidResponse
        }
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(Forecast.self, from: data)
        } catch {
            throw GHError.invalidData
        }
    }
    
    func getAstronomy(location: String) async throws -> AstronomyData {
        let endPoint = "https://api.weatherapi.com/v1/astronomy.json?key=\(API_KEY)&q=\(location)"
        guard let url = URL(string: endPoint) else {
            throw GHError.invalidURL
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        
        print(data)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GHError.invalidResponse
        }
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(AstronomyData.self, from: data)
        } catch {
            throw GHError.invalidData
        }
        
    }
}
