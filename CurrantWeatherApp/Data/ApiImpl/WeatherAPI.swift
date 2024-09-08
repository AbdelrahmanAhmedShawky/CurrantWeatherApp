//
//  WeatherAPI.swift
//  CurrantWeatherApp
//
//  Created by Macbook  on 08/09/2024.
//

import Foundation

class WeatherAPI: WeatherAPIProtocol {
    private let baseURL: String = "https://api.open-meteo.com/v1/forecast"
    
    func fetchForecast(latitude: Double, longitude: Double) async throws -> CurrentWeather {
        var url = URL(string: self.baseURL)!
        url.append(queryItems: [
                    URLQueryItem(name: "latitude", value: String(latitude)),
                    URLQueryItem(name: "longitude", value: String(longitude)),
                    URLQueryItem(name: "hourly", value: "temperature_2m"),
                    URLQueryItem(name: "timezone", value: "auto"),
                    URLQueryItem(name: "current_weather", value: "true"),
        ])
        
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        let statusCode = (response as! HTTPURLResponse).statusCode
        if (statusCode != 200) {
            let answerDict = try JSONSerialization.jsonObject(
                with: data,
                options: .allowFragments
            ) as! [String: Any]
            
            if let reason = answerDict["reason"] {
                throw WeatherError(message: "\(reason)")
            }
        }

        let currant  = try JSONDecoder().decode(WeeklyForecast.self, from: data)
        CoreDataService.shared.saveFromLocalStorage(currant.hourly)
        
        return currant.hourly
    }
}
