//
//  TimeWeatherHorizontalTableCell.swift
//  StretchHeaderTutirial
//
//  Created by tskim on 25/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import UIKit

class TimeSlotHorizontalContainerCell: UICollectionViewCell, NibForName {

    @IBOutlet weak var slotCollectionView: UICollectionView!

    var items: [WeatherTimeSlot] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        slotCollectionView.register(TimeSlotWeatherCell.self)
        slotCollectionView.dataSource = self
        slotCollectionView.backgroundColor = .clear
        if let flowLayout = slotCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.itemSize = CGSize(width: 50, height: 100)
        }
    }
    func reloadData(items: [WeatherTimeSlot]) {
        self.items = items
        slotCollectionView.reloadData()
    }
}

extension TimeSlotHorizontalContainerCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(TimeSlotWeatherCell.self, for: indexPath) else {
            return UICollectionViewCell()
        }
        let item = self.items[indexPath.item]
        cell.representImage.image = UIImage(named: item.imageNmae)
        cell.temperature.text = item.temperature
        cell.time.text = item.time
        return cell
    }
}
