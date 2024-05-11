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
    @State var loDegrees: Double
    @State var hiDegrees: Double
    var inputLocation: String
    @State var locationLoaded = false;
    
    init(location: String) {
        locationName = "Unknown"
        currentDegrees = 10.0
        loDegrees = 0.0
        hiDegrees = 20.0
        inputLocation = location
    }
      
    var body: some View {
        ZStack {
            //Rectangle() // remove this (just for viewing)
            HStack {
                HStack {
                    Text(locationName)
                        .font(.largeTitle.bold())
                        .frame(width: 160, height: 50)
                        .lineLimit(1)
                        .minimumScaleFactor(0.2)
                        .foregroundStyle(.white)
                        .background(.clear, in: RoundedRectangle(cornerRadius: 7, style: .continuous))
                    if locationLoaded {
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
                    else {
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
                    Text("\(String(format: "%.0f", currentDegrees))°C")
                        .font(.title)
                    HStack {
                        Text("L: \(String(format: "%.0f", loDegrees))°C")
                            .font(.caption)
                        Text("H: \(String(format: "%.0f", hiDegrees))°C")
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
                forecastData = try await viewModel.getForecastData(location: inputLocation, days: "1")
                
                if let location = forecastData?.location.name {
                    locationName = location
                }
                if let currentTemp = forecastData?.current.tempC {
                    currentDegrees = currentTemp
                }
                if let firstForecastDay = forecastData?.forecast.forecastday.first {
                    loDegrees = firstForecastDay.day.mintempC
                    hiDegrees = firstForecastDay.day.maxtempC
                }
                locationLoaded = true;
            } catch GHError.invalidURL {
                print("InvalidURL")
            } catch GHError.invalidData {
                print("InvalidData")
            } catch GHError.invalidResponse {
                print("InvalidResponse")
            } catch GHError.bad {
                print("GTFO")
            } catch {
                print("Invalid")
            }
        }
    }
}

#Preview {
    WeatherDataListView(location: "Sydney")
}
