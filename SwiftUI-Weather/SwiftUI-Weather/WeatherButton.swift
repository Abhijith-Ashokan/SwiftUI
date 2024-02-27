//
//  WeatherButton.swift
//  SwiftUI-Weather
//
//  Created by Aoole on 26/02/24.
//

import SwiftUI

struct WeatherButton: View {
    
    var buttonText: String
    var bgColor: Color
    var fgColor: Color
    
    var body: some View {
        Text(buttonText)
            .frame(width: 280, height: 50, alignment: .center)
            .background(bgColor.gradient)
            .font(.system(size: 20, weight: .medium, design: .default))
            .cornerRadius(10)
            .foregroundStyle(Color(fgColor))
    }
}

struct WeatherButton_Previews: PreviewProvider {
    static var previews: some View {
        WeatherButton(buttonText: "Test Title", bgColor: .blue, fgColor: .white)
    }
}
