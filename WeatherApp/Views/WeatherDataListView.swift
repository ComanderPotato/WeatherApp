//
//  CurrentLocationView.swift
//  WeatherApp
//
//  Created by Leonna Myers on 11/5/2024.
//

import SwiftUI

struct WeatherDataListView: View {
    var viewModel = APICalls()
    @State var forecastData: ForecastData?
    @State var locationName: String
    @State var currentDegrees: Double
    @State var lowDegrees: String
    @State var highDegrees: String
    
    init() {
        locationName = "Unknown"
        currentDegrees = 10.0
        lowDegrees = "0.0"
        highDegrees = "20.0"
    }
      
    var body: some View {
        ZStack {
            Rectangle() // remove this (just for viewing)
            HStack {
                HStack {
                    Text(locationName)
                        .font(.largeTitle.bold())
                        .frame(width: 160, height: 50)
                        .lineLimit(1)
                        .minimumScaleFactor(0.2)
                        .foregroundStyle(.white)
                        .background(.clear, in: RoundedRectangle(cornerRadius: 7, style: .continuous))
                    
                    AsyncImage(url: URL(string: "https:" + (forecastData?.current.condition.icon ?? "" ))) { image in
                        
                        image.resizable()
                            .frame(width: 50, height: 50)
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                    } placeholder: {
                        Circle()
                            .foregroundColor(.primary)
                            .frame(width: 20, height: 20)
                            .padding()
                            .background(Color.blue)
                            .clipShape(Rectangle())
                    }
                }
                Spacer()
                VStack {
                    Text("\(String(format: "%.2f", currentDegrees))")
                        .font(.title)
                    HStack {
                        Text("L: " + lowDegrees)
                            .font(.caption)
                        Text("H: " + highDegrees)
                            .font(.caption)
                    }
                }
            }
            .padding()
            .frame(width: 360)
            .foregroundStyle(.white)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 7, style: .continuous))
        }
        .task {
            do {
                forecastData = try await viewModel.getForecastData(location: "Sydney, Ultimo", days: "5")
                forecastData?.forecast.forecastday.forEach { forecastDay in
                    print("Day: ")
                    print(forecastDay.day.mintempC)
                    print(forecastDay.day.maxtempC)
                }
                
                if let location = forecastData?.location.name {
                    locationName = location
                }
                if let currentTemp = forecastData?.current.tempC {
                    currentDegrees = currentTemp
                }
                if let firstForecastDay = forecastData?.forecast.forecastday.first {
                    lowDegrees = firstForecastDay.day.mintempC.formatted()
                    highDegrees = firstForecastDay.day.maxtempC.formatted()
                }
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
    WeatherDataListView()
}
