//
//  ContentView.swift
//  SwiftUI-Weather
//
//  Created by James Boyer on 12/27/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isNight = false
    
    var body: some View {
        ZStack(alignment: .center) {
            BackgroundView(isNight: $isNight)
            VStack{
                CurrentWeatherView(
                    locationName: "Cupertino, CA",
                    imageName: isNight ? "moon.stars.fill" : "cloud.sun.fill",
                    temperature: 76
                )
                Spacer()
                WeeklyWeatherView()
                Spacer()
                WeatherButton(title: "Change Day Time", isNight: $isNight)
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

struct BackgroundView: View {
    @Binding var isNight: Bool
    
    var colorsList: [Color] {
        get {
            return isNight ? [ .black, .gray] : [ .blue, Color("lightBlue")]
        }
    }
    
    var body: some View {
        LinearGradient(
                    gradient: Gradient(colors: colorsList),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            .edgesIgnoringSafeArea(.all)
    }
}

struct CurrentWeatherView: View {
    var locationName: String
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack {
            Text(locationName)
                .font(.system(size: 32, weight: .medium, design: .default))
                .foregroundColor(.white)
                .padding()
            VStack(spacing: 10) {
                Image(systemName: imageName)
                    .renderingMode(.original) // gives us the color combo
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 180, height: 180, alignment: .center)
                Text("\(temperature)°")
                    .font(.system(size: 70, weight: .medium))
                    .foregroundColor(.white)
                    .padding()
            }.padding(.bottom, 40)
        }
    }
}

struct DailyWeatherForcast: Identifiable {
    let dayOfWeek: String
    let imageName: String
    let temperature: Int
    let id = UUID()
}

var weeklyForcast: [DailyWeatherForcast] = [
    DailyWeatherForcast(
        dayOfWeek: "TUE",
        imageName: "cloud.sun.fill",
        temperature: 60
    ),
    DailyWeatherForcast(
        dayOfWeek: "WED",
        imageName: "sun.max.fill",
        temperature: 72
    ),
    DailyWeatherForcast(
        dayOfWeek: "THU",
        imageName: "cloud.snow.fill",
        temperature: 30
    ),
    DailyWeatherForcast(
        dayOfWeek: "FRI",
        imageName: "cloud.sun.rain.fill",
        temperature: 89
    ),
    DailyWeatherForcast(
        dayOfWeek: "SAT",
        imageName: "cloud.sun.bolt.fill",
        temperature: 40
    )
]

struct WeeklyWeatherView: View {
    var body: some View {
        HStack(spacing: 20) {
            ForEach(weeklyForcast) {
                day in WeatherDayView(dayOfWeek: day.dayOfWeek, imageName: day.imageName, temperature: day.temperature)
            }

        }
    }
}

struct WeatherDayView: View {
    var dayOfWeek: String
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack {
            Text(dayOfWeek)
                .font(.system(size: 20, weight: .medium, design: .default))
                .foregroundColor(.white)
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            Text("\(temperature)°") // string interpolation
                .font(.system(size: 30, weight: .medium, design: .default))
                .foregroundColor(.white)
        }
    }
}

struct WeatherButton: View {
    var title: String
    
    @Binding var isNight: Bool
    
    var body: some View {
        Button {
            isNight.toggle()
        } label: {
            Text("Change Day Time")
                .frame(width: 280, height: 50)
                .background(.white)
                .foregroundColor(.blue)
                .font(.system(size:20, weight: .bold, design: .default))
                .cornerRadius(10)
        }

    }
}
