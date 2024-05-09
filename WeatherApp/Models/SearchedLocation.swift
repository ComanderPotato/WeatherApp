//
//  Search.swift
//  WeatherApp
//
//  Created by Tom Golding on 9/5/2024.
//

import Foundation

struct SearchedLocation: Codable {
    let id: Int
    let name, region, country: String
    let lat, lon: Double
    let url: String
}
