//
//  CoreDataStorageServiceProtocol.swift
//  CurrantWeatherApp
//
//  Created by Macbook  on 08/09/2024.
//

import Foundation

protocol CoreDataServiceProtocol {
    func saveFromLocalStorage(_ weather: CurrentWeather)
    func loadInLocalStorage() -> CurrentWeather?
}
