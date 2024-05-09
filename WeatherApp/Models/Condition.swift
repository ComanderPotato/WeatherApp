//
//  Condition.swift
//  WeatherApp
//
//  Created by Tom Golding on 9/5/2024.
//

import Foundation

//struct Condition: Codable {
//    let text: DayText
//    let icon: Icon
//    let code: Int
//}

struct Condition: Codable {
    let text, icon: String
    let code: Int
}
