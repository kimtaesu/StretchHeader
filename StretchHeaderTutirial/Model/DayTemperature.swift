//
//  DayTemperature.swift
//  StretchHeaderTutirial
//
//  Created by tskim on 25/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

struct DayTemperature {
    let dayOfWeek: DayOfWeek
    let imageName: String
    let highestTemperature: Float
    let lowestTemperature: Float
    
    static let sample: [DayTemperature] = {
        let items: [DayTemperature] = [
            DayTemperature(dayOfWeek: .monday, imageName: "wi-sunset", highestTemperature: 31, lowestTemperature: 20),
            DayTemperature(dayOfWeek: .tuesday, imageName: "wi-cloud", highestTemperature: 31, lowestTemperature: 20),
            DayTemperature(dayOfWeek: .wednesday, imageName: "wi-sunset", highestTemperature: 31, lowestTemperature: 20),
            DayTemperature(dayOfWeek: .thursday, imageName: "wi-alien", highestTemperature: 31, lowestTemperature: 20),
            DayTemperature(dayOfWeek: .friday, imageName: "wi-alien", highestTemperature: 31, lowestTemperature: 20),
            DayTemperature(dayOfWeek: .saturday, imageName: "wi-sunset", highestTemperature: 31, lowestTemperature: 20),
            DayTemperature(dayOfWeek: .monday, imageName: "wi-sunset", highestTemperature: 31, lowestTemperature: 20),
            DayTemperature(dayOfWeek: .tuesday, imageName: "wi-cloud", highestTemperature: 31, lowestTemperature: 20),
            DayTemperature(dayOfWeek: .wednesday, imageName: "wi-sunset", highestTemperature: 31, lowestTemperature: 20),
            DayTemperature(dayOfWeek: .thursday, imageName: "wi-alien", highestTemperature: 31, lowestTemperature: 20),
            DayTemperature(dayOfWeek: .friday, imageName: "wi-alien", highestTemperature: 31, lowestTemperature: 20),
            DayTemperature(dayOfWeek: .saturday, imageName: "wi-sunset", highestTemperature: 31, lowestTemperature: 20)
        ]
        
        return items
    }()
}
