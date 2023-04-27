//
//  APIManager.swift
//  Final Project
//
//  Created by user230914 on 4/20/23.
//

import Foundation

class APIManager {
    static let shared = APIManager()
    private init() {}
    
    let weatherBaseURL = "https://api.weatherapi.com/v1"
    let apiKey = "5ec1a0e1d7204978bac161413232004"

        
        func fetchWeatherData(location: String, completion: @escaping (Result<WeatherAPIResponse, Error>) -> Void) {
            let url = URL(string: "\(weatherBaseURL)/forecast.json?key=\(apiKey)&q=\(location)&days=7")
            
            guard let requestURL = url else {
                completion(.failure(APIError.invalidURL))
                return
            }
            
            let task = URLSession.shared.dataTask(with: requestURL) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(APIError.invalidData))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let weatherResponse = try decoder.decode(WeatherAPIResponse.self, from: data)
                    completion(.success(weatherResponse))
                } catch {
                    completion(.failure(error))
                }
            }
            
            task.resume()
        }
    }

    enum APIError: Error {
        case invalidURL
        case invalidData
    }

   
