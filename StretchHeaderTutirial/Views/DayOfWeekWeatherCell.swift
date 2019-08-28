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
    // MARK: - View Life Cycle
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        
        guard let attributes = layoutAttributes as? CustomLayoutAttributes else {
            return
        }
        
        weatherView.transform = attributes.parallax
    }
}
