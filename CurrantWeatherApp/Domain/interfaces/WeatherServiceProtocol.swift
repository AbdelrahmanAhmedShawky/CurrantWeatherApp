//
//  WeatherServiceProtocol.swift
//  CurrantWeatherApp
//
//  Created by Macbook  on 08/09/2024.
//

import Foundation

protocol WeatherServiceProtocol {
    func fetchForecast(latitude: Double, longitude: Double) async throws -> CurrentWeather?
}
