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
    @ObservedObject var introViewModel = CurrentLocationManager()
    @State var locationLoaded = false

    var body: some View {
        NavigationStack {
            ZStack {
                Rectangle()
                    .fill()
                    .ignoresSafeArea()
                VStack {
                    Text("Loading...")
                        .foregroundColor(.white)
                        .font(.title)
                }
            }
            .onAppear {
                introViewModel.onViewDidLoad()
            }
            .onReceive(introViewModel.$currentCity) { _ in
                self.locationLoaded = true
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    IntroView()
}
