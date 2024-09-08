//
//  Double+Extention.swift
//  CurrantWeatherApp
//
//  Created by Macbook  on 08/09/2024.
//

import Foundation

extension Double {
    
    func rounded(toDecimalPlaces decimalPlaces: Int) -> Double {
        let factor = pow(10.0, Double(decimalPlaces))
        return (self * factor).rounded() / factor
    }
    
    func toCelsius() -> Double {
        return (self - 32) * 5/9
    }
    
    func toFahrenheit() -> Double {
        return (self * 9/5) + 32
    }
    
}
