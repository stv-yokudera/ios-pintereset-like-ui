//
//  PinterestCollectionViewLayout.swift
//  ios-pinterest-like-ui
//
//  Created by YukiOkudera on 2018/05/19.
//  Copyright © 2018年 YukiOkudera. All rights reserved.
//

import UIKit

final class PinterestCollectionViewLayout: UICollectionViewLayout {

    weak var delegate: PinterestLayoutDelegate?
    var numberOfColumns = 2
    var cellPadding = CGFloat(8.0)

    var cache = [PinterestCollectionViewLayoutAttributes]()

    var contentHeight = CGFloat(0.0)
    var contentWidth: CGFloat {
        let insets = collectionView!.contentInset
        return collectionView!.bounds.width - (insets.left + insets.right)
    }

    override class var layoutAttributesClass: AnyClass {
        return PinterestCollectionViewLayoutAttributes.self
    }
    
    /// レイアウトの事前準備
    override func prepare() {

        super.prepare()

        guard cache.isEmpty else {
            return
        }

        guard let collectionView = collectionView else {
            return
        }

        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        var offsetX = [CGFloat]()

        for column in 0 ..< numberOfColumns {
            let offset = CGFloat(column) * columnWidth
            offsetX.append(offset)
        }

        var column = 0
        var offsetY = [CGFloat](repeating: 0, count: numberOfColumns)

        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {


            let indexPath = IndexPath(item: item, section: 0)

            let width = columnWidth - cellPadding * 2
            let photoHeight = delegate?.collectionView(
                collectionView: collectionView,
                heightForPhotoAtIndexPath: indexPath,
                withWidth: width
            )

            let labelHeight = delegate?.collectionView(
                collectionView: collectionView,
                heightForCaptionAndCommentAtIndexPath: indexPath,
                withWidth: width
            )

            let height = cellPadding + photoHeight! + labelHeight!

            let frame = CGRect(x: offsetX[column],
                               y: offsetY[column],
                               width: columnWidth,
                               height: height)

            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)

            let attributes = PinterestCollectionViewLayoutAttributes(forCellWith: indexPath)

            attributes.photoHeight = photoHeight!
            attributes.frame = insetFrame
            cache.append(attributes)

            contentHeight = max(contentHeight, frame.maxY)
            offsetY[column] = offsetY[column] + height

            column = column >= numberOfColumns - 1 ? 0 : column + 1
        }
    }

    /// コンテンツサイズ
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }

    /// 表示する要素
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {

        var layoutAttributes = [UICollectionViewLayoutAttributes]()

        for attributes in cache {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
}
