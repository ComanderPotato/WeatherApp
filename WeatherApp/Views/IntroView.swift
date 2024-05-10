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
    @ObservedObject var introViewModel = IntroViewModel()
    @State private var locationLoaded = false

    var body: some View {
        NavigationView {
            ZStack {
                Rectangle()
                    .fill()
                    .ignoresSafeArea()
                VStack {
                    if locationLoaded {
                        NavigationLink(destination: MainDashboardView()) {
                            Text("Loaded")
                                .foregroundColor(.white)
                                .font(.title)
                        }
                    } else {
                        Text("Loading...")
                            .foregroundColor(.white)
                            .font(.title)
                    }
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
