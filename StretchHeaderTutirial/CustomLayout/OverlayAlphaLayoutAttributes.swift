//
//  ParallaxLayoutAttributes.swift
//  StretchHeaderTutirial
//
//  Created by tskim on 29/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import UIKit

final class OverlayAlphaLayoutAttributes: UICollectionViewLayoutAttributes {

    var headerOverlayAlpha = CGFloat(0)
    var initialOrigin: CGPoint = .zero

    override func copy(with zone: NSZone?) -> Any {
        guard let copiedAttributes = super.copy(with: zone) as? OverlayAlphaLayoutAttributes else {
            return super.copy(with: zone)
        }

        copiedAttributes.headerOverlayAlpha = headerOverlayAlpha
        copiedAttributes.initialOrigin = initialOrigin
        return copiedAttributes
    }

    override func isEqual(_ object: Any?) -> Bool {
        guard let otherAttributes = object as? OverlayAlphaLayoutAttributes else {
            return false
        }

        if otherAttributes.headerOverlayAlpha != headerOverlayAlpha || otherAttributes.initialOrigin != initialOrigin {
            return false
        }

        return super.isEqual(object)
    }
}
