//
//  BackgroundView.swift
//  CurrantWeatherApp
//
//  Created by Macbook  on 09/09/2024.
//

import Foundation
import SwiftUI

struct BackgroundView: View {
    
    var isNight: Bool
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [isNight ? .black : .blue, isNight ? .gray : Color("lightBlue")]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
        .ignoresSafeArea(.all)
    }
}
