//
//  ContentView.swift
//  SwiftUI-Weather
//
//  Created by Aoole on 26/02/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var isNight = false
    
    var body: some View {
        ZStack {
            BackgroundGradientView(isNight: isNight)
            
            VStack {
                CityTextName(cityName: "Cupertino, CA")
                MainWeatherView(imageName: isNight ? "moon.stars.fill" : "cloud.sun.fill", temp: 76)
                HStack(spacing: 20) {
                    WeatherDayView(dayOfTheWeek: "TUE", imageName: "cloud.sun.fill", temperature: 76)
                    WeatherDayView(dayOfTheWeek: "WED", imageName: "sun.max.fill", temperature: 88)
                    WeatherDayView(dayOfTheWeek: "THU", imageName: "sun.rain.fill", temperature: 55)
                    WeatherDayView(dayOfTheWeek: "FRI", imageName: "sun.rain.fill", temperature: 58)
                    WeatherDayView(dayOfTheWeek: "SAT", imageName: "cloud.sun.fill", temperature: 70)
                }
                Spacer()
                Button {
                    isNight.toggle()
                } label: {
                    WeatherButton(buttonText: "Change Day Time", bgColor: .white, fgColor: .blue )
                }
                Spacer()
            }
        }
    }
}

#Preview {
    ContentView()
}

struct WeatherDayView: View {
    
    var dayOfTheWeek: String
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack {
            Text(dayOfTheWeek)
                .foregroundStyle(Color.white)
                .font(.system(size: 16, weight: .medium))
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            Text("\(temperature)°")
                .font(.system(size:28, weight: .medium))
                .foregroundStyle(Color(.white))
        }
    }
}

struct BackgroundGradientView: View {
    
    var isNight: Bool
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [isNight ? .black : .blue, isNight ? .gray : .lightBlue]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
        .ignoresSafeArea()
    }
}

struct CityTextName: View {
    
    var cityName: String
    
    var body: some View {
        Text(cityName)
            .font(.system(size: 32, weight: .medium, design: .default))
            .foregroundStyle(Color(.white))
            .padding( )
    }
}

struct MainWeatherView: View {
    
    var imageName: String
    var temp: Int
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: imageName)
                .symbolRenderingMode(.multicolor)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            Text("\(temp)°")
                .font(.system(size:70, weight: .medium))
                .foregroundStyle(Color(.white))
        }
        .padding(.bottom, 40)
    }
}
