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
        case .dayOfWeek:
            return 1
        case .timeHorizontal:
            return 1
        }
    }
    var identifier: String {
        switch self {
        case .dayOfWeek:
            return DayOfWeekVerticalContainerCell.swiftIdentifier
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
    func items<T: Equatable>() -> [T] {
        switch self {
        case .dayOfWeek(let section):
            return section.items as? [T] ?? []
        case .timeHorizontal(let section):
            return section.items as? [T] ?? []
        }
    }
}

struct NotificationNames {
    static let setOffset = "setOffset"
}

class ViewController: UIViewController {
    
    struct Metrics {
        static let HeaderHeight: CGFloat = 250
        static let HorizontalWeatherCellHeight: CGFloat = 130
    }
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

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        let cloudLayer = CALayer()
        cloudLayer.fillCloudImage(self.view.bounds)
        self.view.layer.addSublayer(cloudLayer)
        collectionView.backgroundColor = .clear
        collectionView.register(DayOfWeekVerticalContainerCell.self)
        collectionView.register(TimeSlotHorizontalContainerCell.self)
        collectionView.register(SummaryHeaderView.self, kind: UICollectionView.elementKindSectionHeader)
        collectionView.collectionViewLayout = flowLayout
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.alwaysBounceVertical = false
        view.addSubview(collectionView)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let headerHeightMaxChange = Metrics.HorizontalWeatherCellHeight
        var subOffset: CGFloat = 0
        if offsetY > headerHeightMaxChange {
            subOffset = offsetY - headerHeightMaxChange
        } else {
            subOffset = 0
        }
        NotificationCenter.default.post(name: Notification.Name(rawValue: NotificationNames.setOffset), object: subOffset)
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let section = self.sections[section]
        switch section.identifier {
        case TimeSlotHorizontalContainerCell.swiftIdentifier:
            return CGSize(width: collectionView.rowWidth, height: Metrics.HeaderHeight)
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
        case DayOfWeekVerticalContainerCell.swiftIdentifier:
            guard let cell = collectionView.dequeueReusableCell(DayOfWeekVerticalContainerCell.self, for: indexPath)
                else { return UICollectionViewCell() }

            cell.reloadData(items: section.items())
            cell.backgroundColor = .clear
            return cell
        case TimeSlotHorizontalContainerCell.swiftIdentifier:
            guard let cell = collectionView.dequeueReusableCell(TimeSlotHorizontalContainerCell.self, for: indexPath)
                else { return UICollectionViewCell() }
            cell.reloadData(items: self.timeSlots)
            return cell
        default: break
        }
        return UICollectionViewCell()
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegateLayoutAttribute {
    func collectionView(_ collectionView: UICollectionView, kind: String, forSupplementary indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            return OverlayAlphaLayoutAttributes(forSupplementaryViewOfKind: kind, with: indexPath)
        default: return nil
        }
    }
    func collectionView(_ collectionView: UICollectionView, forItemAt indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let section = self.sections[indexPath.section]
        switch section.identifier {
        case TimeSlotHorizontalContainerCell.swiftIdentifier:
            return StickyLayoutAttributes(forCellWith: indexPath)
        default:
            return nil
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let section = self.sections[indexPath.section]
        print("sizeForItemAt: \(section.identifier)")
        switch section.identifier {
        case DayOfWeekVerticalContainerCell.swiftIdentifier:
            return CGSize(width: collectionView.rowWidth, height: 700)
        case TimeSlotHorizontalContainerCell.swiftIdentifier:
            return CGSize(width: collectionView.rowWidth, height: Metrics.HorizontalWeatherCellHeight)
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
