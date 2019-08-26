//
//  UILabel+STyle.swift
//  StretchHeaderTutirial
//
//  Created by tskim on 26/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import UIKit

extension ViewStyle where T: UILabel {
    static var headerTtitle: ViewStyle<T> {
        return ViewStyle<T> { label in
            label.textColor = .white
            label.setTextSize(40)
            label.textAlignment = .center
            return label
        }
    }
    static var headerSubTtitle: ViewStyle<T> {
        return ViewStyle<T> { label in
            label.textColor = .white
            label.setTextSize(20)
            label.textAlignment = .center
            return label
        }
    }
}
