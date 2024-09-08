//
//  WeatherAPIProtocol.swift
//  CurrantWeatherApp
//
//  Created by Macbook  on 08/09/2024.
//

import Foundation

protocol WeatherAPIProtocol {
    func fetchForecast(latitude: Double, longitude: Double) async throws -> CurrentWeather
}
