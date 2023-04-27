//
//  WeatherViewModel.swift
//  Final Project
//
//  Created by user230914 on 4/20/23.
//
import SwiftUI

class WeatherViewModel: ObservableObject {
    @Published private(set) var weather: WeatherData?
    @Published private(set) var dailyForecasts: [DailyForecast] = []
    @Published var isLoading = false
    
    var temperatureFahrenheit: Double {
        weather?.temperatureFahrenheit ?? 0.0
    }
    
    var humidity: Int {
        weather?.humidity ?? 0
    }
    
    var windSpeed: Double {
        weather?.windSpeed ?? 0.0
    }
    
    var conditionText: String {
        weather?.condition.text ?? ""
        
    }
    
    var conditionIcon: String {
        weather?.condition.icon ?? ""
    }
    
    func searchLocation(location: String) {
        fetchWeatherData(location: location)
    }
    
    func fetchWeatherData(location: String) {
        APIManager.shared.fetchWeatherData(location: location) { result in
            switch result {
            case .success(let weatherResponse):
                DispatchQueue.main.async {
                    self.weather = weatherResponse.current
                    self.dailyForecasts = weatherResponse.forecast.forecastday
                }
            case .failure(let error):
                print("Error fetching weather data: \(error)")
            }
        }
    }
}
