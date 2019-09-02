//
//  SlotWeatherCell.swift
//  StretchHeaderTutirial
//
//  Created by tskim on 25/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import UIKit

class TimeSlotWeatherCell: UICollectionViewCell, NibForName {
    
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var representImage: UIImageView!
    @IBOutlet weak var temperature: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        temperature.textAlignment = .center
    }
    
    func configCell(item: WeatherTimeSlot) {
        representImage.image = UIImage(named: item.imageNmae)?.withRenderingMode(.alwaysTemplate)
        temperature.text = item.temperature
        time.text = item.time
    }
}
