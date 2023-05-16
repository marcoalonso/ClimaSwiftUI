//
//  WeatherViewModel.swift
//  Clima
//
//  Created by Marco Alonso Rodriguez on 26/03/23.
//

import Foundation
//https://api.openweathermap.org/data/2.5/weather?appid=698cb29c0a1e70d1a30a0a9982f6a95a&units=metric&lang=es&q=morelia


final class WeatherViewModel: ObservableObject {
    @Published var weatherResponseDataModel: ResponseDataModel?
    @Published var weatherModel: WeatherModel?
    @Published var error: String?
    
    let wrapper = WeatherModelMapper()

    @MainActor
    func getWeather(city: String) async {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?appid=698cb29c0a1e70d1a30a0a9982f6a95a&units=metric&lang=es&q=\(city.replacingOccurrences(of: " ", with: "%20"))") else { return }
        
        print("Debug: url \(url)")

        
        do {
            async let (data, _) = try await URLSession.shared.data(from: url)
            let dataModel = try await JSONDecoder().decode(ResponseDataModel.self, from: data)
//            self.weatherResponseDataModel = dataModel
            self.weatherModel = wrapper.mapDataModelToModel(dataModel: dataModel)
        } catch {
            print("Debug: error \(error.localizedDescription)")
            self.error = error.localizedDescription
        }
    }
}
