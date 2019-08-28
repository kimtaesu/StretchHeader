//
//  WeatherTimeSlot.swift
//  StretchHeaderTutirial
//
//  Created by tskim on 25/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation

struct WeatherTimeSlot: Equatable, IdentifiableType {
    let id: String = UUID().uuidString
    let time: String
    let imageNmae: String
    let temperature: String
    
    var identity: String {
        return id
    }
}

extension WeatherTimeSlot {
    static let sample: [WeatherTimeSlot] = [
        WeatherTimeSlot(time: "Now", imageNmae: "wi-sunset", temperature: "20"),
        WeatherTimeSlot(time: "12", imageNmae: "wi-sunset", temperature: "20"),
        WeatherTimeSlot(time: "13", imageNmae: "wi-sunset", temperature: "20"),
        WeatherTimeSlot(time: "14", imageNmae: "wi-sunset", temperature: "20"),
        WeatherTimeSlot(time: "15", imageNmae: "wi-sunset", temperature: "20"),
        WeatherTimeSlot(time: "16", imageNmae: "wi-sunset", temperature: "20"),
        WeatherTimeSlot(time: "17", imageNmae: "wi-sunset", temperature: "20"),
        WeatherTimeSlot(time: "18", imageNmae: "wi-sunset", temperature: "20"),
        WeatherTimeSlot(time: "19", imageNmae: "wi-sunset", temperature: "20"),
        WeatherTimeSlot(time: "20", imageNmae: "wi-sunset", temperature: "20"),
        WeatherTimeSlot(time: "21", imageNmae: "wi-sunset", temperature: "20"),
        WeatherTimeSlot(time: "22", imageNmae: "wi-sunset", temperature: "20"),
        WeatherTimeSlot(time: "23", imageNmae: "wi-sunset", temperature: "20"),
        WeatherTimeSlot(time: "24", imageNmae: "wi-sunset", temperature: "20")
    ]
}
