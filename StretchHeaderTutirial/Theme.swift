//
//  Theme.swift
//  StretchHeaderTutirial
//
//  Created by tskim on 26/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import UIKit

struct Theme {

    static var labelTextColor: UIColor?

    static public func defaultTheme() {
        self.labelTextColor = .darkGray
        updateDisplay()
    }

    static public func darkTheme() {
        self.labelTextColor = .white
        updateDisplay()
    }

    static public func updateDisplay() {
        UILabel.appearance().textColor = self.labelTextColor
    }
}
