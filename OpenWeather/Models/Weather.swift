//
//  Weather.swift
//  OpenWeather
//
//  Created by Sateesh Yemireddi on 7/11/21.
//

import Foundation

// MARK: - Weather
struct Weather: Codable, Identifiable {
    let weather: [WeatherElement]?
    let base: String?
    let main: Main?
    let visibility: Int?
    let wind: Wind?
    let rain: Rain?
    let date: Int?
    let id: Int?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case weather
        case base
        case main
        case visibility
        case wind
        case rain
        case date = "dt"
        case id
        case name
    }
}

struct Main: Codable {
    let temparature: Double?
    let feelsLike: Double?
    let tempMin: Double?
    let tempMax: Double?
    let pressure: Int?
    let humidity: Int?
    let seaLevel: Int?
    let groundLevel: Int?

    enum CodingKeys: String, CodingKey {
        case temparature = "temp"
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case humidity
        case seaLevel = "sea_level"
        case groundLevel = "grnd_level"
    }
}

struct WeatherElement: Codable {
    let id: Int?
    let main: String?
    let weatherDescription: String?
    let icon: String?

    enum CodingKeys: String, CodingKey {
        case id
        case main
        case weatherDescription = "description"
        case icon
    }
}

struct Rain: Codable {
    let the1H: Double?
    let the3H: Double?

    enum CodingKeys: String, CodingKey {
        case the1H = "1h"
        case the3H = "3h"
    }
}

struct Wind: Codable {
    let speed: Double?
    let deg: Int?
    let gust: Double?
}

//MARK: - Formatted Weather
struct WeatherFormatted {
    var temparature: String = ""
    var condition: String = ""
    var description: String = ""
    var image: String = ""
    var feelsLike: String = ""
    var minMaxTemparature: String = ""
    var rainPercent: String = ""
    var windDirection: String = ""
}
