//
//  DayTemperature.swift
//  StretchHeaderTutirial
//
//  Created by tskim on 25/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//
import Foundation

struct WeatherDaySlot: Equatable, IdentifiableType {
    let id: String = UUID().uuidString
    let dayOfWeek: DayOfWeek
    let imageName: String
    let highestTemperature: Float
    let lowestTemperature: Float
    
    var identity: String {
        return id
    }
}

extension WeatherDaySlot {
    static let sample: [WeatherDaySlot] = {
        let items: [WeatherDaySlot] = [
            WeatherDaySlot(dayOfWeek: .monday, imageName: "wi-sunset", highestTemperature: 31, lowestTemperature: 20),
            WeatherDaySlot(dayOfWeek: .tuesday, imageName: "wi-cloud", highestTemperature: 31, lowestTemperature: 20),
            WeatherDaySlot(dayOfWeek: .wednesday, imageName: "wi-sunset", highestTemperature: 31, lowestTemperature: 20),
            WeatherDaySlot(dayOfWeek: .thursday, imageName: "wi-alien", highestTemperature: 31, lowestTemperature: 20),
            WeatherDaySlot(dayOfWeek: .friday, imageName: "wi-alien", highestTemperature: 31, lowestTemperature: 20),
            WeatherDaySlot(dayOfWeek: .saturday, imageName: "wi-sunset", highestTemperature: 31, lowestTemperature: 20),
            WeatherDaySlot(dayOfWeek: .monday, imageName: "wi-sunset", highestTemperature: 31, lowestTemperature: 20),
            WeatherDaySlot(dayOfWeek: .tuesday, imageName: "wi-cloud", highestTemperature: 31, lowestTemperature: 20),
            WeatherDaySlot(dayOfWeek: .wednesday, imageName: "wi-sunset", highestTemperature: 31, lowestTemperature: 20),
            WeatherDaySlot(dayOfWeek: .thursday, imageName: "wi-alien", highestTemperature: 31, lowestTemperature: 20),
            WeatherDaySlot(dayOfWeek: .friday, imageName: "wi-alien", highestTemperature: 31, lowestTemperature: 20),
            WeatherDaySlot(dayOfWeek: .saturday, imageName: "wi-sunset", highestTemperature: 31, lowestTemperature: 20)
        ]
        
        return items
    }()
}
