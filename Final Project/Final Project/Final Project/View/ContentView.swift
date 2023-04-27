//
//  ContentView.swift
//  Final Project
//
//  Created by user230914 on 4/20/23.
//
import SwiftUI

struct ContentView: View {
    @StateObject var weatherViewModel = WeatherViewModel()
    @State private var location = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 0.0, green: 122/255, blue: 1.0)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    TextField("Enter location", text: $location, onCommit: {
                        weatherViewModel.searchLocation(location: location)
                    })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    
                    if weatherViewModel.weather != nil {
                        VStack {
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Weather")
                                    .font(.system(size: 36, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding(.bottom)
                                
                                Text("Temperature: \(weatherViewModel.temperatureFahrenheit, specifier: "%.1f") °F")
                                    .font(.system(size: 24, weight: .bold))
                                
                                Text("Humidity: \(weatherViewModel.humidity)%")
                                    .font(.system(size: 20, weight: .medium))
                                
                                Text("Wind Speed: \(weatherViewModel.windSpeed, specifier: "%.1f") mph")
                                    .font(.system(size: 20, weight: .medium))
                                
                                HStack {
                                    Text("\(weatherViewModel.conditionText)")
                                        .font(.system(size: 18, weight: .medium))
                                    
                                    RemoteImage(url: "https:\(weatherViewModel.conditionIcon)")
                                        .frame(width: 50, height: 50)
                                }
                            }
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue.opacity(0.6))
                            .cornerRadius(20)
                            
                            // Daily Forecast
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(weatherViewModel.dailyForecasts, id: \.date) { dailyForecast in
                                        VStack(alignment: .center, spacing: 10) {
                                            Text(dailyForecast.date)
                                                .font(.system(size: 18, weight: .medium))
                                            
                                            Text("\(dailyForecast.day.avgTemp, specifier: "%.1f") °F")
                                                .font(.system(size: 24, weight: .bold))
                                            
                                            Text("\(dailyForecast.day.condition.text)")
                                                .font(.system(size: 16, weight: .medium))
                                        }
                                        .padding()
                                        .background(Color.blue.opacity(0.6))
                                        .cornerRadius(20)
                                        .foregroundColor(.white)
                                    }
                                }
                            }
                            .padding(.top)
                            
                            // Add navigation to detailed views
                        }
                        .padding()
                    } else {
                        ActivityIndicator(isAnimating: $weatherViewModel.isLoading, style: .large)
                    }
                }
            }
            .navigationBarTitle("Weather", displayMode: .inline)
        }
    }
}
