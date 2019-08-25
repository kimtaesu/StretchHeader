//
//  DayOfWeekCell.swift
//  StretchHeaderTutirial
//
//  Created by tskim on 25/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import UIKit
import Accelerate
class DayOfWeekWeatherView: UIView, NibLoadable {

    @IBOutlet var container: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var dayOfWeekName: UILabel!
    @IBOutlet weak var representImage: UIImageView!
    @IBOutlet weak var highest: UILabel!
    @IBOutlet weak var lowest: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }

    private func initView() {
        setupFromNib()
        representImage.contentMode = .scaleAspectFit
    }
}
