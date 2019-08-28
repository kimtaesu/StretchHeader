/**
 * Copyright (c) 2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit

final class CustomLayout: UICollectionViewFlowLayout {

    enum Element: String {
        case sectionHeader
        case sectionFooter
        case cell

        var id: String {
            return self.rawValue
        }

        var kind: String {
            return "Kind\(self.rawValue.capitalized)"
        }
    }


    override public class var layoutAttributesClass: AnyClass {
        return CustomLayoutAttributes.self
    }

    override public var collectionViewContentSize: CGSize {
        return CGSize(width: collectionViewWidth, height: contentHeight)
    }

    // MARK: - Properties
    var settings = CustomLayoutSettings()
    private var oldBounds = CGRect.zero
    private var contentHeight = CGFloat()
    private var cache = [Element: [IndexPath: CustomLayoutAttributes]]()
    private var visibleLayoutAttributes = [CustomLayoutAttributes]()
    private var zIndex = 0

    private var collectionViewHeight: CGFloat {
        return collectionView!.frame.height
    }

    private var collectionViewWidth: CGFloat {
        return collectionView!.frame.width
    }

    private var menuSize: CGSize {
        guard let menuSize = settings.menuSize else {
            return .zero
        }

        return menuSize
    }

    private var contentOffset: CGPoint {
        return collectionView!.contentOffset
    }
}

// MARK: - LAYOUT CORE PROCESS
extension CustomLayout {

    override public func prepare() {
        guard let collectionView = collectionView
//            cache.isEmpty
            else {
                return
        }

        prepareCache()
        contentHeight = 0
        zIndex = 0
        oldBounds = collectionView.bounds

        let sections = collectionView.numberOfSections
        for section in 0..<sections {
            let itemCount = collectionView.numberOfItems(inSection: section)

            if let flowDelegateLayout = collectionView.delegate as? UICollectionViewDelegateFlowLayout,
                let headerSize = flowDelegateLayout.collectionView?(collectionView, layout: self, referenceSizeForHeaderInSection: section) {

                let headerAttributes = CustomLayoutAttributes(
                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                    with: IndexPath(item: 0, section: section)
                )
                print("headerSize: \(headerSize)")
                prepareHeaderFooterElement(size: headerSize, kind: UICollectionView.elementKindSectionHeader, attributes: headerAttributes)
            }
            for item in 0..<itemCount {
                var itemSize = self.itemSize
                if let flowDelegateLayout = collectionView.delegate as? UICollectionViewDelegateFlowLayout,
                    let size = flowDelegateLayout.collectionView?(collectionView, layout: self, sizeForItemAt: IndexPath(item: item, section: section)) {
                    itemSize = size
                }

                let cellIndexPath = IndexPath(item: item, section: section)
                let attributes = CustomLayoutAttributes(forCellWith: cellIndexPath)
                let lineInterSpace = self.minimumLineSpacing
                attributes.frame = CGRect(
                    x: 0 + self.minimumInteritemSpacing,
                    y: contentHeight + lineInterSpace,
                    width: itemSize.width,
                    height: itemSize.height
                )
                contentHeight = attributes.frame.maxY
                cache[.cell]?[cellIndexPath] = attributes
            }
        }
    }

    private func prepareCache() {
        cache.removeAll(keepingCapacity: true)
        cache[.sectionHeader] = [IndexPath: CustomLayoutAttributes]()
        cache[.sectionFooter] = [IndexPath: CustomLayoutAttributes]()
        cache[.cell] = [IndexPath: CustomLayoutAttributes]()
    }
    private func prepareHeaderFooterElement(size: CGSize, kind: String, attributes: CustomLayoutAttributes) {
        guard size != .zero else { return }

        attributes.initialOrigin = CGPoint(x: 0, y: contentHeight)
        attributes.frame = CGRect(origin: attributes.initialOrigin, size: size)

        attributes.zIndex = zIndex
        zIndex += 1

        contentHeight = attributes.frame.maxY
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            cache[.sectionHeader]?[attributes.indexPath] = attributes
        case UICollectionView.elementKindSectionFooter:
            cache[.sectionFooter]?[attributes.indexPath] = attributes
        default:
            break
        }
    }
}

//MARK: - PROVIDING ATTRIBUTES TO THE COLLECTIONVIEW
extension CustomLayout {

    override public func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        if oldBounds.size != newBounds.size {
            cache.removeAll(keepingCapacity: true)
        }
        return true
    }

    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        switch elementKind {
        case UICollectionView.elementKindSectionHeader:
            return cache[.sectionHeader]?[indexPath]
        case UICollectionView.elementKindSectionFooter:
            return cache[.sectionFooter]?[indexPath]
        default:
            return nil
        }
    }
    override public func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[.cell]?[indexPath]
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let collectionView = collectionView else { return nil }
        visibleLayoutAttributes.removeAll(keepingCapacity: true)

        for (type, elementInfos) in cache {
            for (indexPath, attributes) in elementInfos {
                attributes.parallax = .identity
                attributes.transform = .identity

                updateSupplementaryViews(type, attributes: attributes, collectionView: collectionView, indexPath: indexPath)
                if attributes.frame.intersects(rect) {
                    visibleLayoutAttributes.append(attributes)
                }
            }
        }
        return visibleLayoutAttributes
    }

    private func updateSupplementaryViews(_ type: Element, attributes: CustomLayoutAttributes, collectionView: UICollectionView, indexPath: IndexPath) {
        switch type {
        case .sectionHeader:
            let headerSize = attributes.frame.size
            let updatedHeight = min(
                collectionView.frame.height,
                max(headerSize.height, headerSize.height - contentOffset.y))

            let scaleFactor = updatedHeight / headerSize.height
            let delta = (updatedHeight - headerSize.height) / 2
            let scale = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)
            let translation = CGAffineTransform(translationX: 0, y: min(contentOffset.y, headerSize.height) + delta)
            attributes.transform = scale.concatenating(translation)
            attributes.headerOverlayAlpha = max(0,  1 - (contentOffset.y / headerSize.height))
        default: break
        }
    }
}
