//
//  WeatherModelMapper.swift
//  Clima
//
//  Created by Marco Alonso Rodriguez on 26/03/23.
//

import Foundation

struct WeatherModelMapper {
    func mapDataModelToModel(dataModel: ResponseDataModel) -> WeatherModel {
        
        let city = dataModel.name
        let temperature = String(format: "%.1f", dataModel.main.temp)
        let description = dataModel.weather.first?.description ?? ""
        let url = URL(string: "https://openweathermap.org/img/wn/\(dataModel.weather.first?.icon ?? "04d")@2x.png")
        let humidity = "\(dataModel.main.humidity)%"
        
        return WeatherModel(city: city, description: description, iconURL: url, currentTemperature: "\(temperature) °C", humidity: humidity)
    }
}
