//
//  ContentView.swift
//  WeatherApp
//
//  Created by Tom Golding on 8/5/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var weatherData: WeatherData?
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(weatherData?.location.country ?? "Fail")
        }
        .padding()
        .task {
            do {
                weatherData = try await getWeatherData()
            } catch GHError.invalidURL {
                print("InvalidURL")
            } catch GHError.invalidData {
                print("InvalidData")

            } catch GHError.invalidResponse {
                print("InvalidResponse")

            } catch GHError.bad {
                print("BOO")
            }
            catch {
                print("Invalid")
            }
        }
    }

    func getWeatherData() async throws -> WeatherData {
        let API_KEY = "78f67b17b64a41acbbb22331240905"
        let endPoint = "http://api.weatherapi.com/v1/current.json?key=\(API_KEY)&q=London"
        guard let url = URL(string: endPoint) else {
            throw GHError.invalidURL
        }
        print("PAST URL CHECK")
        let (data, response) = try await URLSession.shared.data(from: url)
        print("PAST URLSESSION")

        print(data)
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
}

#Preview {
    ContentView()
}

enum GHError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case bad
}

//func getCurrent() async throws -> WeatherData{
//        let API_KEY = "78f67b17b64a41acbbb22331240905"
//        let endPoint = "http://api.weatherapi.com/v1/current.json?key=\(API_KEY)&q=London"
//        guard let url = URL(string: endPoint) else {
//            throw GHError.invalidURL
//        }
////        print(url)
//
//        let (data, response) = try await URLSession.shared.data(from: url)
//        print("MAkes it past")
//        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//            throw GHError.invalidResponse
//        }
//        do {
//            let decoder = JSONDecoder()
////            decoder.keyDecodingStrategy = .convertFromSnakeCase
//            return try decoder.decode(WeatherData.self, from: data)
//        } catch {
//            throw GHError.invalidData
//        }
//    }
