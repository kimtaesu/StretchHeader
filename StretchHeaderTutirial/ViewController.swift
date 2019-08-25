//
//  ViewController.swift
//  StretchHeaderTutirial
//
//  Created by tskim on 25/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import UIKit


enum CellType: String, CellTag {
    case dayOfWeek
    case timeHorizontal

    var tag: Int {
        switch self {
        case .dayOfWeek:
            return 0
        case .timeHorizontal:
            return 1
        }
    }
}

class ViewController: UIViewController {

    var items: [DayTemperature] = DayTemperature.sample
    var header: WeatherHeader = WeatherHeader(city: "Chicago", weatherDesc: "sunny", temperature: 20)

    let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(DayOfWeekWeatherCell.self)
        collectionView.register(TimeHorizontalCell.self)
        collectionView.register(SummaryHeaderView.self, kind: UICollectionView.elementKindSectionHeader)
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.pinEdges(to: view)
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let contentWidth = collectionView.safeAreaLayoutGuide.layoutFrame.width

        return CGSize(width: contentWidth, height: 130)
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let cell = collectionView.dequeueReusableSupplementaryView(
                SummaryHeaderView.self,
                kind: kind,
                for: indexPath
            ) else { return UICollectionReusableView() }

            cell.city.text = header.city
            cell.weatherDesc.text = header.weatherDesc
            cell.temperature.text = String(header.temperature)
            return cell
        default:
            return UICollectionReusableView()
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        switch indexPath.section {
        case CellType.dayOfWeek.tag:
            guard let cell = collectionView.dequeueReusableCell(DayOfWeekWeatherCell.self, for: indexPath) else { return UICollectionViewCell() }
            let item = items[indexPath.row]
            cell.weatherView.dayOfWeekName.text = item.dayOfWeek.name
            cell.weatherView.highest.text = String(item.highestTemperature)
            cell.weatherView.lowest.text = String(item.lowestTemperature)
            cell.weatherView.representImage.image = UIImage(named: item.imageName)
            return cell
        case CellType.timeHorizontal.tag:
            break
        default: break
        }
        return UICollectionViewCell()
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.getSingleWidth(height: 130)
    }
}
