//
//  WeatherService.swift
//  CurrantWeatherApp
//
//  Created by Macbook  on 08/09/2024.
//

import Foundation
import SystemConfiguration

class WeatherService: WeatherServiceProtocol {
   
    private var weatherAPI: WeatherAPIProtocol
    private var weatherlocal: CoreDataServiceProtocol
    
    required init (weatherAPI: WeatherAPIProtocol = WeatherAPI(), weatherlocal: CoreDataServiceProtocol = CoreDataService.shared) {
        self.weatherAPI = weatherAPI
        self.weatherlocal = weatherlocal
    }
    
    func fetchForecast(latitude: Double, longitude: Double) async throws -> CurrentWeather? {
        if Reachability.isConnected(){
            return try await weatherAPI.fetchForecast(latitude: latitude, longitude: longitude)
        } else {
            guard let data = weatherlocal.loadInLocalStorage() else {
                print("Not data in Local")
                return CurrentWeather(time: [], temperature2M: [])
            }
            return data
        }
    }
}
