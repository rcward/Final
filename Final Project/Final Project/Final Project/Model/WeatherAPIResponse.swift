//
//  WeatherAPIResponse.swift
//  Final Project
//
//  Created by user230914 on 4/25/23.
//

import Foundation

struct WeatherAPIResponse: Codable {
    let current: WeatherData
    let forecast: Forecast
}

struct WeatherData: Codable {
    let temperature: Double
    let humidity: Int
    let windSpeed: Double
    let condition: Condition

    var temperatureFahrenheit: Double {
        return temperature
    }

    enum CodingKeys: String, CodingKey {
        case temperature = "temp_f"
        case humidity = "humidity"
        case windSpeed = "wind_mph"
        case condition = "condition"
    }
}

struct Condition: Codable {
    let text: String
    let icon: String
}

struct Forecast: Codable {
    let forecastday: [DailyForecast]
}

struct DailyForecast: Codable {
    let date: String
    let day: DailyWeather
}

struct DailyWeather: Codable {
    let maxTemp: Double
    let minTemp: Double
    let avgTemp: Double
    let condition: Condition

    enum CodingKeys: String, CodingKey {
        case maxTemp = "maxtemp_f"
        case minTemp = "mintemp_f"
        case avgTemp = "avgtemp_f"
        case condition = "condition"
    }
}

