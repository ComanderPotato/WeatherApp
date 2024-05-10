//
//  Intro.swift
//  WeatherApp
//
//  Created by Leonna Myers on 10/5/2024.
//

import SwiftUI

// prompt current location
// placeholder design


struct IntroView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill()
                .ignoresSafeArea()
            Text("The Best Weather App Ever") // insert name
                .foregroundColor(.white)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
        }
    }
}

#Preview {
    IntroView()
}
