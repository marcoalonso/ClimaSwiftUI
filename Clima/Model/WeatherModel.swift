//
//  WeatherModel.swift
//  Clima
//
//  Created by Marco Alonso Rodriguez on 26/03/23.
//

import Foundation

struct WeatherModel {
    let city: String
    let description: String
    let iconURL: URL?
    let currentTemperature: String
    let humidity: String
    
    static let empty: WeatherModel = .init(city: "No city", description: "No description", iconURL: nil, currentTemperature: "0°", humidity: "0%")
}
