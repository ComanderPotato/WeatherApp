//
//  LocationView.swift
//  WeatherApp
//
//  Created by Tom Golding on 10/5/2024.
//

import SwiftUI

struct LocationView: View {
    @StateObject var viewModel = LocationViewModel()
    @State private var forecastData: ForecastData?
    var body: some View {
        ZStack {
            WeatherHeaderView(location: forecastData?.location ?? createDummyLocation(), forecastDay: forecastData?.forecast.forecastday.first ?? createDummyForecastday())
        }.task {
            do {
                forecastData = try await viewModel.getForecastData(location: "Sydney, Ultimo", days: "5")
    
            } catch GHError.invalidURL {
                print("InvalidURL")
            } catch GHError.invalidData {
                print("InvalidData")
            } catch GHError.invalidResponse {
                print("InvalidResponse")
            } catch GHError.bad {
                print("BOO")
            } catch {
                print("Invalid")
            }
        }
    }
}

#Preview {
    LocationView()
}
