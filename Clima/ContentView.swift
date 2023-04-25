//
//  ContentView.swift
//  Clima
//
//  Created by Marco Alonso Rodriguez on 26/03/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var weatherViewModel = WeatherViewModel()
    @State private var ciudadBuscar: String = ""

    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                
                TextField("Ciudad o pais", text: $ciudadBuscar)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .frame(height: 50)
                    .padding([.leading, .trailing], 50)
                    .onSubmit {
                        fetchClima(nameCity: ciudadBuscar)
                    }
                
                HStack {
                    
                    if let iconURL = weatherViewModel.weatherModel?.iconURL {
                        AsyncImage(url: iconURL) { image in
                            image
                        } placeholder: {
                            ProgressView()
                        }
                    }
                    
                    Text(weatherViewModel.weatherModel?.currentTemperature ?? "0.0")
                        .font(.system(size: 60))
                        .foregroundColor(.white)
                }
                
                
                Text(weatherViewModel.weatherModel?.city ?? "No city")
                    .foregroundColor(.white)
                    .font(.system(size: 60))
                
               
                Text(weatherViewModel.weatherModel?.description ?? "")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(.bottom, 8)
                
                
                    
                Label("\(weatherViewModel.weatherModel?.humidity ?? "0") Humedad", systemImage: "humidity.fill")
                    .font(.title)
                    .symbolRenderingMode(.multicolor)
                    .foregroundColor(.white)
                
                Spacer()
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

        }
        .background(
            LinearGradient(colors: [.blue, .green], startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        
        .task {
            //Obtener la ubicacion y pedir el clima con las coordenadas de la ciudad
            await weatherViewModel.getWeather(city: "Morelia")
        }
    }
    
    func fetchClima(nameCity: String) {
        Task {
            await weatherViewModel.getWeather(city: ciudadBuscar.trimmingCharacters(in: .whitespaces))
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.ciudadBuscar = ""
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
