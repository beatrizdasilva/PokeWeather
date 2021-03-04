//
//  WeatherResponse.swift
//  PokeWeather
//
//  Created by Juliana Pereira Machado on 23/02/21.
//

import Foundation

struct Weather: Codable{
    let main: String
}

struct WeatherResponse: Codable {
    let weather: [Weather]
    let name: String
}

enum weatherResponse {
    case clear
    case rain
    case thunderstorm
    case snow
    case mist
    case clouds
}
