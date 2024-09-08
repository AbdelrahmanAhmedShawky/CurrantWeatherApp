//
//  WeatherViewModel.swift
//  CurrantWeatherApp
//
//  Created by Macbook  on 08/09/2024.
//

import Foundation
import SwiftUI

class WeatherViewModel: ObservableObject {
    private var weatherService: WeatherService
    @Published private var weather: CurrentWeather?
    @Published private var isNight: Bool = false
   
    
    @Published var toFahrenheit: Int = 0 {
        didSet {
            Task { @MainActor in
                convertTo()
            }
        }
    }
    
    required init(weatherService: WeatherService) {
        self.weatherService = weatherService
    }
    
    func hasData() -> Bool {
        return self.weather != nil
    }
    
    func emptyData() -> Bool {
        return self.weather?.temperature2M == []
    }
    
    @MainActor
    private func convertTo() {
        var newList: [Double] = []
        newList = self.weather?.temperature2M.map { temp in
            toFahrenheit == 1 ? temp.toFahrenheit().rounded(toDecimalPlaces: 2) : temp.toCelsius().rounded(toDecimalPlaces: 2)
        } ?? []
        self.weather?.temperature2M = newList
    }
    
    func fetchWeather(latitude: Double, longitude: Double) async {
        Task { @MainActor in
            do {
                if let currentWeather = try await weatherService.fetchForecast(latitude: latitude, longitude: longitude) {
                    self.weather = currentWeather
                }
            } catch let error as WeatherError {
                print(error.message)
                
            } catch let error {
                print(error.localizedDescription)
            }
        }
        
    }
    
    var dayWeatherListView: some View {
        VStack {
            Divider()
            ScrollView(.horizontal) {
                HStack(spacing: 10) {
                    ForEach(1...24, id: \.self) { index in
                        let temperature = self.weather?.temperature2M[index]
                        if let temperature = temperature {
                            WeatherDayView(dayOfWeek: self.getWeekDay(offset: index), imageName: self.getWeatherImageByTemperature(temperature: Int(temperature)), temperature: Int(temperature))
                            
                        }
                    }
                }.padding()
            }.frame(height: 100)
            Divider()
            Spacer()
        }
    }
    
    var mainWeatherStatusView: some View {
        MainWeatherStatusView(
            imageName: self.isNight ? "moon.stars.fill" : "cloud.sun.fill",
            temperature: self.weather?.temperature2M != nil ? Int((self.weather?.temperature2M[0])!) : 0)
    }
         
    var backgroundView: some View {
        BackgroundView(isNight: self.isNight)
    }
    
    func getWeatherImageByTemperature(temperature: Int) -> String {
        if temperature >= 28 && (temperature < 70 || temperature > 81) {
            return "sun.max.fill"
        } else if temperature <= 20 && temperature > 14 && temperature < 70 {
            return "cloud.rain.fill"
        } else if temperature <= 14 && temperature > 8 {
            return "wind"
        } else if temperature <= 8 {
            return "snowflake"
        }
        return "cloud.sun.fill"
    }

    func getWeekDay(offset: Int) -> String {
        let currentDate = Date()
        var dateComponent = DateComponents()
        dateComponent.day = offset
        let futureDate = Calendar.current.date(byAdding: dateComponent, to: currentDate)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        dateFormatter.locale = Locale.current
        
        return dateFormatter.string(from: futureDate!).uppercased()
    }
    
}
