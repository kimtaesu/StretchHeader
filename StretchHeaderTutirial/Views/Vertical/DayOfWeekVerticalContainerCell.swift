//
//  DayOfWeekVerticalCell.swift
//  StretchHeaderTutirial
//
//  Created by tskim on 29/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import UIKit

class DayOfWeekVerticalContainerCell: UICollectionViewCell, NibForName {

    @IBOutlet weak var collectionView: UICollectionView!

    var items: [WeatherDaySlot] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(DayOfWeekWeatherCell.self)
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.alwaysBounceVertical = false
        NotificationCenter.default.addObserver(self, selector: #selector(handleSetOffset), name: Notification.Name(rawValue: NotificationNames.setOffset), object: nil)
    }
    func reloadData(items: [WeatherDaySlot]) {
        self.items = items
        collectionView.reloadData()
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .vertical
            flowLayout.itemSize = CGSize(width: self.frame.width, height: 50)
        }
    }
    @objc func handleSetOffset(notification: Notification) {
        if let offset = notification.object as? CGFloat {
            collectionView.contentOffset = CGPoint(x: 0, y: offset)
        }
    }
}

extension DayOfWeekVerticalContainerCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(DayOfWeekWeatherCell.self, for: indexPath) else {
            return UICollectionViewCell()
        }
        let item = self.items[indexPath.item]

        cell.weatherView.configCell(slot: item)
        cell.weatherView.clearBackgroundcolor()
        cell.backgroundColor = .clear
        return cell
    }
}
