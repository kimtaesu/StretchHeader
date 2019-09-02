//
//  DayOfWeekWeatherTableCell.swift
//  StretchHeaderTutirial
//
//  Created by tskim on 25/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import UIKit

class DayOfWeekWeatherCell: UICollectionViewCell, NibForName  {
    
    @IBOutlet weak var weatherView: DayOfWeekWeatherView!
    
    func clearBackgroundcolor() {
        weatherView.clearBackgroundcolor()
        self.backgroundColor = .clear
    }
}
