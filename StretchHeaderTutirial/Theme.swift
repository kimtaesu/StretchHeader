//
//  Theme.swift
//  StretchHeaderTutirial
//
//  Created by tskim on 26/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import UIKit

struct Theme {


    static public func defaultTheme() {
        let tintColor = UIColor.darkGray
        UILabel.appearance().textColor = tintColor
        UIImageView.appearance().tintColor = tintColor
    }

    static public func darkTheme() {
        let tintColor = UIColor.white
        UILabel.appearance().textColor = tintColor
        UIImageView.appearance().tintColor = tintColor
    }
}
