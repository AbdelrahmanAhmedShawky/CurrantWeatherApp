//
//  ErrorView.swift
//  CurrantWeatherApp
//
//  Created by Macbook  on 09/09/2024.
//

import Foundation
import SwiftUI

struct ErrorView: View {
    var errorText: String
    
    var body: some View {
        VStack {
            Image(systemName: "xmark.octagon")
                    .resizable()
                .frame(width: 100, height: 100, alignment: .center)
                .padding(.bottom, 30)
            Text(errorText)
                .font(.system(size: 20, weight: .bold))
                .multilineTextAlignment(.center)
        }
        .padding()
        .foregroundColor(.white)
    }
}

