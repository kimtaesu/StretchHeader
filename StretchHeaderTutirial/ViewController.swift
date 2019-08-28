//
//  ViewController.swift
//  StretchHeaderTutirial
//
//  Created by tskim on 25/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import UIKit


enum CellType {
    case dayOfWeek(WeatherDaySlotSection)
    case timeHorizontal(WeatherTimeSlotSection)
}

extension CellType: CellAdapter {

    var itemCount: Int {
        switch self {
        case .dayOfWeek(let section):
            return section.items.count
        case .timeHorizontal:
            return 1
        }
    }
    var identifier: String {
        switch self {
        case .dayOfWeek:
            return DayOfWeekWeatherCell.swiftIdentifier
        case .timeHorizontal:
            return TimeSlotHorizontalContainerCell.swiftIdentifier
        }
    }

    func item<T: Equatable>(for index: Int) -> T? {
        switch self {
        case .dayOfWeek(let section):
            return section.items[index] as? T
        case .timeHorizontal(let section):
            return section.items[index] as? T
        }
    }
}

class ViewController: UIViewController {
    var sections: [CellType] = [
            .timeHorizontal(WeatherTimeSlotSection(items: WeatherTimeSlot.sample)),
            .dayOfWeek(WeatherDaySlotSection(items: WeatherDaySlot.sample))

    ]
    var timeSlots: [WeatherTimeSlot] = WeatherTimeSlot.sample
    var header: WeatherHeader = WeatherHeader(city: "Chicago", weatherDesc: "sunny", temperature: 20)

    @IBOutlet weak var collectionView: UICollectionView!
    private lazy var flowLayout: CustomLayout = {
        let flowLayout = CustomLayout()
        flowLayout.scrollDirection = .vertical
        return flowLayout
    }()
    
//
//    lazy var collectionView: UICollectionView = {
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
//        return collectionView
//    }()

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cloudLayer = CALayer()
        cloudLayer.fillCloudImage(self.view.bounds)
        self.view.layer.addSublayer(cloudLayer)
        collectionView.backgroundColor = .clear
        collectionView.register(DayOfWeekWeatherCell.self)
        collectionView.register(TimeSlotHorizontalContainerCell.self)
        collectionView.register(SummaryHeaderView.self, kind: UICollectionView.elementKindSectionHeader)
        collectionView.collectionViewLayout = flowLayout
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        
        flowLayout.settings.isSectionHeadersSticky = true
        flowLayout.settings.headerOverlayMaxAlphaValue = CGFloat(0.6)
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        let section = self.sections[section]
        switch section.identifier {
        case TimeSlotHorizontalContainerCell.swiftIdentifier:
            return CGSize(width: collectionView.rowWidth, height: 200)
        default:
            return .zero
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.sections[section].itemCount
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
        let section = self.sections[indexPath.section]
        switch section.identifier {
        case DayOfWeekWeatherCell.swiftIdentifier:
            guard let cell = collectionView.dequeueReusableCell(DayOfWeekWeatherCell.self, for: indexPath),
                let item: WeatherDaySlot = section.item(for: indexPath.item)
                else { return UICollectionViewCell() }

            cell.weatherView.configCell(slot: item)
            cell.backgroundColor = .clear
            cell.weatherView.clearBackgroundcolor()
            cell.weatherView.representImage.image = UIImage(named: item.imageName)
            return cell
        case TimeSlotHorizontalContainerCell.swiftIdentifier:
            guard let cell = collectionView.dequeueReusableCell(TimeSlotHorizontalContainerCell.self, for: indexPath)
                else { return UICollectionViewCell() }
            cell.slotCollectionView.backgroundColor = .clear
            cell.reloadData(items: self.timeSlots)
            return cell
        default: break
        }
        return UICollectionViewCell()
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let section = self.sections[indexPath.section]
        print("sizeForItemAt: \(section.identifier)")
        switch section.identifier {
        case DayOfWeekWeatherCell.swiftIdentifier:
            return CGSize(width: collectionView.rowWidth, height: 50)
        case TimeSlotHorizontalContainerCell.swiftIdentifier:
            return CGSize(width: collectionView.rowWidth, height: 130)
        default: break

        }
        return .zero
    }
}

extension CALayer {
    func fillCloudImage(_ rect: CGRect) {
        let bgImage = #imageLiteral(resourceName: "bg_weather")
        self.frame = rect
        self.contents = bgImage.cgImage
        self.contentsGravity = .resizeAspectFill
    }
}
