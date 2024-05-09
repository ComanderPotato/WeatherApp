//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Tom Golding on 9/5/2024.
//

import Foundation

struct WeatherData: Codable {
    let location: Location
    let current: Current
}
