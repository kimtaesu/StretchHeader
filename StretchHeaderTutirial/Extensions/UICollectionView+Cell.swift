//
//  UICollectionView+Cell.swift
//  StretchHeaderTutirial
//
//  Created by tskim on 25/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import UIKit

extension UICollectionView {
    func register < T: UICollectionViewCell & NibForName > (_ reusableCell: T.Type) {
        register(reusableCell.nib, forCellWithReuseIdentifier: reusableCell.swiftIdentifier)
    }
    func register < T: UICollectionReusableView & NibForName > (_ reusableCell: T.Type, kind: String) {
        register(reusableCell.nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: reusableCell.swiftIdentifier)
    }
    func dequeueReusableSupplementaryView < T: UICollectionReusableView & NibForName > (
        _ reusableCell: T.Type,
        kind: String,
        for indexPath: IndexPath
    ) -> T? {
        return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reusableCell.swiftIdentifier, for: indexPath) as? T
    }
    func dequeueReusableCell < T: UICollectionViewCell & NibForName > (
        _ reusableCell: T.Type,
        for indexPath: IndexPath
    ) -> T? {
        return dequeueReusableCell(withReuseIdentifier: reusableCell.swiftIdentifier, for: indexPath) as? T
    }
    
    var rowWidth: CGFloat {
        guard let collectionViewLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return safeAreaLayoutGuide.layoutFrame.width
                - contentInset.left
                - contentInset.right
        }
        
        let sectionInset = collectionViewLayout.sectionInset
        return safeAreaLayoutGuide.layoutFrame.width
            - sectionInset.left
            - sectionInset.right
            - contentInset.left
            - contentInset.right
    }
}
