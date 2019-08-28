//
//  SummaryHeaderView.swift
//  StretchHeaderTutirial
//
//  Created by tskim on 25/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import UIKit

class SummaryHeaderView: UICollectionReusableView, NibForName {
    
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var weatherDesc: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var container: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        city.apply(.headerTtitle)
        temperature.apply(.headerTtitle)
        weatherDesc.apply(.headerSubTtitle)
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        guard let layoutAttributes = layoutAttributes as? CustomLayoutAttributes else {
            return
        }
        print("!!!!!!! apply \(layoutAttributes.headerOverlayAlpha)")
        temperature.alpha = layoutAttributes.headerOverlayAlpha
        weatherDesc.alpha = layoutAttributes.headerOverlayAlpha
    }
}
