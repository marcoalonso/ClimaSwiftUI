//
//  ContentView.swift
//  Clima
//
//  Created by Marco Alonso Rodriguez on 26/03/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var weatherViewModel = WeatherViewModel()
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Text(weatherViewModel.weatherResponseDataModel?.name ?? "No city")
                    .foregroundColor(.white)
                    .font(.system(size: 70))
                Text(weatherViewModel.weatherResponseDataModel?.weather[0].description ?? "")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding(.bottom, 8)
                HStack {
                    Text("\(weatherViewModel.weatherResponseDataModel?.main.temp ?? 0.0)°")
                        .font(.system(size: 70))
                        .foregroundColor(.white)
                }
                .padding(.top, -20)
                HStack(spacing: 15) {
                    if let iconURL = weatherViewModel.weatherResponseDataModel?.weather.first?.icon, let url = URL(string: "http://openweathermap.org/img/wn/\(iconURL)@2x.png") {
                        AsyncImage(url: url) { image in
                            image
                        } placeholder: {
                            ProgressView()
                        }

                    }
                    Label("\(weatherViewModel.weatherResponseDataModel?.main.tempMax ?? 0.0)°", systemImage: "thermometer.sun.fill")
                        .font(.system(size: 30))
                    Label("\(weatherViewModel.weatherResponseDataModel?.main.tempMin ?? 0.0)°", systemImage: "thermometer.snowflake")
                        .font(.system(size: 30))
                }
                .symbolRenderingMode(.multicolor)
                .foregroundColor(.white)
                Divider()
                    .foregroundColor(.white)
                    .padding()
                Label("\(weatherViewModel.weatherResponseDataModel?.main.humidity ?? 0)%", systemImage: "humidity.fill")
                    .symbolRenderingMode(.multicolor)
                    .foregroundColor(.white)
                Spacer()
                
            }
            .padding(.top, 32)
        }
        .background(
            LinearGradient(colors: [.blue, .green], startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .task {
            await weatherViewModel.getWeather(city: "Morelia")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
