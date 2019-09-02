//
//  UICollectionViewCellIdentifyType.swift
//  StretchHeaderTutirial
//
//  Created by tskim on 29/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import UIKit

@objc protocol UICollectionViewDelegateLayoutAttribute: class {
    func collectionView(_ collectionView: UICollectionView, forItemAt indexPath: IndexPath) -> UICollectionViewLayoutAttributes?
    @objc optional func collectionView(_ collectionView: UICollectionView, kind: String, forSupplementary indexPath: IndexPath) -> UICollectionViewLayoutAttributes?
}
