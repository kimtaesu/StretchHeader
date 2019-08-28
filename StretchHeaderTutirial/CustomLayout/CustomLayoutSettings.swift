//
//  CustomLayoutSettings.swift
//  StretchHeaderTutirial
//
//  Created by tskim on 27/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import UIKit

struct CustomLayoutSettings {

    // Elements sizes
    var menuSize: CGSize?
    var isHorizontalWeatherSticky: Bool
    var isSectionHeadersSticky: Bool
    var headerOverlayMaxAlphaValue: CGFloat
}

extension CustomLayoutSettings {

    init() {
        self.menuSize = nil
        self.isHorizontalWeatherSticky = false
        self.isSectionHeadersSticky = false
        self.headerOverlayMaxAlphaValue = 0
    }
}
