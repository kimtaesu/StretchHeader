//
//  Sections.swift
//  StretchHeaderTutirial
//
//  Created by tskim on 25/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation

struct WeatherDaySlotSection: SectionModelType {
    var items: [WeatherDaySlot]
    
    var identity: String {
        return "daysection"
    }
    init(items: [WeatherDaySlot]) {
        self.items = items
    }
}

struct WeatherTimeSlotSection: SectionModelType {
    var items: [WeatherTimeSlot]
    
    var identity: String {
        return "timesection"
    }
    init(items: [WeatherTimeSlot]) {
        self.items = items
    }
}

