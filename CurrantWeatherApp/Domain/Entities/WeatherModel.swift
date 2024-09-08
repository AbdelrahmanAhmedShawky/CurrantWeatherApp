import Foundation

// MARK: - Weather Model
struct WeeklyForecast: Codable {
    var hourly: CurrentWeather
    
    enum CodingKeys: String, CodingKey {
        case hourly = "hourly"
    }
    
}

// MARK: - CurrentWeather
struct CurrentWeather: Codable {
    var time: [String]
    var temperature2M: [Double]
    
    enum CodingKeys: String, CodingKey {
        case time
        case temperature2M = "temperature_2m"
    }
}
