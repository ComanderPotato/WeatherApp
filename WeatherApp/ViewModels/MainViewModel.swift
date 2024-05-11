//
//  MainViewModel.swift
//  WeatherApp
//
//  Created by Leonna Myers on 11/5/2024.
//

import Foundation

class MainViewModel: ObservableObject {
    @Published var weatherDataListViews: [ForecastDataListView] = []
    var saveData = SaveData()
    var currentLocationAdded = false
    
    init() {
        // retrieve stored data here
    }
    
    func addWeatherDataListView(view: ForecastDataListView) {
        weatherDataListViews.append(view)
    }
    
    func addCurrentLocation(location: String) {
        currentLocationAdded = true;
        if location != "Loading..." && !currentLocationAdded {
            addWeatherDataListView(view: ForecastDataListView(location: location))
            print("added")
        }
    }
    
    func addViews() {
        
    }
}
