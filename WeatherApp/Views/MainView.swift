//
//  MainDashboard.swift
//  WeatherApp
//
//  Created by Leonna Myers on 10/5/2024.
//

import SwiftUI

// note - will change the colours to custom stuff
// background - just a placeholder for now to see if i am successfully glassifying
// i have some ideas - i will see how much time i have

struct MainView: View {
    @ObservedObject var locationManager = CurrentLocationManager()
    @State private var searchQuery = ""
    @State private var locationLoaded = false
    @State private var currentLocation = "Unknown"
    
    var body: some View {
        NavigationStack {
            ZStack {
                Rectangle()
                    .fill(LinearGradient(colors: [.indigo, .black], startPoint: .topTrailing, endPoint: .bottom))
                    .ignoresSafeArea()
                
                VStack {
                    // search locations box
                    NavigationLink {
                        SearchView()
                    } label: {
                        HStack(alignment: .firstTextBaseline) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.white)
                                .padding(.trailing, 8)
                            UITextFieldWrapper(text: $searchQuery)
                                .padding()
                                .onTapGesture {}
                                .disableAutocorrection(true)
                                .autocorrectionDisabled()
                                .autocapitalization(/*@START_MENU_TOKEN@*/ .none/*@END_MENU_TOKEN@*/)
                                .frame(width: 200, height: 30)
                            Spacer()
                        }
                        .padding()
                        .frame(width: 360)
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 7, style: .continuous))
                    }
                    .padding()
                    
                    // welcome//header box
                    HStack {
                        if locationLoaded {
                            Text(currentLocation)
                                .font(.system(size: 36, weight: .bold, design: .rounded))
                                .padding()
                                .frame(width: 360)
                                .foregroundStyle(LinearGradient(colors: [.white, .white], startPoint: .top, endPoint: .bottom)) // experimenting
                                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 7, style: .continuous))
                        }
                        else {
                            Text("Welcome")
                                .font(.system(size: 36, weight: .bold, design: .rounded))
                                .padding()
                                .frame(width: 360)
                                .foregroundStyle(LinearGradient(colors: [.white, .white], startPoint: .top, endPoint: .bottom)) // experimenting
                                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 7, style: .continuous))
                        }
                    }
                    .padding()
                    // current location + saved locations
                    VStack(alignment: .leading) {
                        VStack {
                            if locationLoaded {
                                WeatherDataListView(location: currentLocation)
                            }
                        }
                        VStack {
                            //saved for each
                        }
                        Spacer()
                    }

                }
                .onAppear {
                    locationManager.onViewDidLoad()
                }
                .onReceive(locationManager.$currentCity) { _ in
                    locationLoaded = true
                    currentLocation = locationManager.currentCity
                }
                
                
            }
        }
    }
    
    // will move
    
    struct UITextFieldWrapper: UIViewRepresentable {
        @Binding var text: String
        
        func makeUIView(context: Context) -> UITextField {
            let textField = UITextField()
            textField.delegate = context.coordinator
            // textField.borderStyle = .roundedRect
            textField.placeholder = "Search"
            textField.autocorrectionType = .no
            textField.autocapitalizationType = .none
            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.textColor = .white
            return textField
        }
        
        func updateUIView(_ uiView: UITextField, context: Context) {
            uiView.text = text
        }
        
        func makeCoordinator() -> Coordinator {
            Coordinator(text: $text)
        }
        
        class Coordinator: NSObject, UITextFieldDelegate {
            @Binding var text: String
            
            init(text: Binding<String>) {
                _text = text
            }
            
            func textFieldDidChangeSelection(_ textField: UITextField) {
                text = textField.text ?? ""
                if text.count >= 200 {
                    text = String(text.prefix(199))
                }
            }
        }
    }
}

#Preview {
    MainView()
}
