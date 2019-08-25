//
//  DayOfWeek.swift
//  StretchHeaderTutirial
//
//  Created by tskim on 25/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

enum DayOfWeek {
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday
    
    var name: String {
        switch self {
        case .monday:
            return "월요일"
        case .tuesday:
            return "월요일"
        case .wednesday:
            return "수요일"
        case .thursday:
            return "목요일"
        case .friday:
            return "금요일"
        case .saturday:
            return "토요일"
        case .sunday:
            return "일요일"
        }
    }
}
