//
//  ContentView.swift
//  WeatherApp
//
//  Created by Ivica Petrsoric on 11/05/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            BackgroundView(topColor: Color.blue, bottomColor: Color("lightBlue"))
            
            VStack {
                CityTextView(cityName: "Curpertino, CA")
                
                MainWeatherStatusView(imageName: "cloud.sun.fill", temperature: 70)
                
                
                HStack (spacing: 20) {
                    WeatherDayView(deyOfWeek: "TUE",
                                   imageName: "cloud.sun.fill",
                                   temperature: 50)
                    
                    WeatherDayView(deyOfWeek: "WED",
                                   imageName: "cloud.sun.bolt.fill",
                                   temperature: 40)
                    
                    WeatherDayView(deyOfWeek: "THU",
                                   imageName: "cloud.moon.rain.fill",
                                   temperature: 30)
                    
                    WeatherDayView(deyOfWeek: "FRI",
                                   imageName: "cloud.heavyrain.fill",
                                   temperature: 22)
                    
                    WeatherDayView(deyOfWeek: "SAT",
                                   imageName: "sun.dust.fill",
                                   temperature: 40)
                    
                }
                
                Spacer()
                
                Button {
                    
                } label: {
                    WeatherButton(title: "Change Day Time", textColor: Color.blue, background: Color.white)
                }
                
                Spacer()

            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct WeatherDayView: View {
    
    var deyOfWeek: String
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack(spacing: 12) {
            Text(deyOfWeek)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white)
            
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            Text("\(temperature)°")
                .font(.system(size: 28, weight: .medium))
                .foregroundColor(.white)
        }
    }
}

struct BackgroundView: View {
    
    var topColor: Color
    var bottomColor: Color
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [topColor, bottomColor]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
    }
}

struct CityTextView: View {
    
    var cityName: String
    
    var body: some View {
        Text(cityName)
            .font(.system(size: 32, weight: .medium, design: .default))
            .foregroundColor(.white)
            .padding()
    }
}

struct MainWeatherStatusView: View {
    
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            Text("\(temperature)°")
                .font(.system(size: 70, weight: .bold))
                .foregroundColor(.white)
        }.padding(.bottom, 40)
    }
}

struct WeatherButton: View {
    
    var title: String
    var textColor: Color
    var background: Color
    
    var body: some View {
        Text("Change Day Time")
            .frame(width: 280, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .background(background)
            .foregroundColor(textColor)
            .font(.system(size: 20, weight: .bold, design: .default))
            .cornerRadius(10)
    }
}
