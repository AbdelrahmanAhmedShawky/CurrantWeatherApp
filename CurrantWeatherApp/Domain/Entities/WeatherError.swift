import Foundation

class WeatherError: LocalizedError {
    var message: String
    
    init(message: String){
        self.message = message
    }
}
