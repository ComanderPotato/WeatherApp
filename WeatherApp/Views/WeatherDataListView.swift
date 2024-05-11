//
//  CurrentLocationView.swift
//  WeatherApp
//
//  Created by Leonna Myers on 11/5/2024.
//

import SwiftUI

struct WeatherDataListView: View {
    // let weatherData: WeatherData

    // init(weatherData: WeatherData) {
    // self.weatherData = weatherData
    // }

    // testing
    let locationName = "Sydney"
    let currentDegrees = "20°C"
    let lowDegrees = "10°C"
    let highDegrees = "30°C"

    var body: some View {
        ZStack {
            Rectangle()
            HStack {
                HStack{
                    Text(locationName)
                        .font(.largeTitle.bold())
                        .frame(width: 160, height: 50)
                        .lineLimit(1)
                        .minimumScaleFactor(0.2)
                        .foregroundStyle(.white)
                        .background(.clear, in: RoundedRectangle(cornerRadius: 7, style: .continuous))

                    Image(systemName: "photo")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .padding()
                            .background(Color.blue)
                            .clipShape(Rectangle())
                }
                Spacer()
                VStack{
                    Text(currentDegrees)
                        .font(.title)
                    HStack {
                        Text("L: " + lowDegrees)
                            .font(.caption)
                        Text ("H: " + highDegrees)
                            .font(.caption)
                    }
                }
            }
            .padding()
            .frame(width: 360)
            .foregroundStyle(.white)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 7, style: .continuous))
        }
    }
}

#Preview {
    WeatherDataListView()
}
