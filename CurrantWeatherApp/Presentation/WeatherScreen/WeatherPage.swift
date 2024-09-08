//
//  WeatherPage.swift
//  CurrantWeatherApp
//
//  Created by Macbook  on 09/09/2024.
//

import Foundation
import SwiftUI

struct WeatherPage: View {
    @ObservedObject var viewModel: WeatherViewModel
    @StateObject var locationViewModel = LocationViewModel()
    
    init() {
        self.viewModel = WeatherViewModel(weatherService: WeatherService(weatherAPI: WeatherAPI()))
    }
    
    var body: some View {
        ZStack {
            viewModel.backgroundView
            switch locationViewModel.authorizationStatus {
            case .notDetermined:
                AnyView(locationViewModel.requestLocationButton)
            case .restricted:
                ErrorView(errorText: "Location use is restricted.")
            case .denied:
                ErrorView(errorText: "The app does not have location permissions. Please enable them in settings.")
            case .authorizedAlways, .authorizedWhenInUse:
                if viewModel.hasData() {
                    if viewModel.emptyData() {
                        ContentUnavailableView {
                            Label("No data in local storage", systemImage: "doc.richtext.fill")
                        } description: {
                            Button {
                                Task {
                                    await fetchForecast()
                                }
                            } label: {
                                WeatherButton(title: "Retry", textColor: .blue, backgroundColor: .white)
                            }
                        }
                    } else {
                        VStack {
                            Spacer()
                            Picker("Selected", selection: $viewModel.toFahrenheit, content: {
                                Text("Celsius").tag(0)
                                Text("Fahrenheit").tag(1)
                            })
                            .pickerStyle(SegmentedPickerStyle()).padding()
                            
                            Spacer()
                            locationViewModel.cityTextView
                            viewModel.mainWeatherStatusView
                            
                            HStack(spacing: 20) {
                                viewModel.dayWeatherListView
                            }
                            Spacer()
                        }
                    }
                  
                } else {
                    ProgressView()
                        .onAppear() {
                            locationViewModel.addListener(callback: {
                                Task {
                                    await fetchForecast()
                                }
                            })
                        }
                }
            default:
                Text("Unexpected status")
            }
        }
    }
    
    func fetchForecast() async {
        await viewModel.fetchWeather(latitude: locationViewModel.lastSeenLocation?.coordinate.latitude ?? 0, longitude: locationViewModel.lastSeenLocation?.coordinate.longitude ?? 0)
    }
    
}


struct WeatherPage_Previews: PreviewProvider {
    static var previews: some View {
        WeatherPage()
    }
}

