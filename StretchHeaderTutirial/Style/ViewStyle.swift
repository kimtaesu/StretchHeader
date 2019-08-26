//
//  ViewStyle.swift
//  StretchHeaderTutirial
//
//  Created by tskim on 26/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//
import Foundation
import UIKit

struct ViewStyle<T> {
    let style: (T) -> T
}

protocol Stylable {
    init()
}

extension UIView: Stylable {}

extension Stylable {
    
    init(style: ViewStyle<Self>) {
        self.init()
        apply(style)
    }
    
    @discardableResult
    func apply(_ style: ViewStyle<Self>) -> Self {
        return style.style(self)
    }
}
