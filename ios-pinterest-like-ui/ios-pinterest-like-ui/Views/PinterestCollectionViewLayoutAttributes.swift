//
//  PinterestCollectionViewLayoutAttributes.swift
//  ios-pinterest-like-ui
//
//  Created by YukiOkudera on 2018/05/19.
//  Copyright © 2018年 YukiOkudera. All rights reserved.
//

import UIKit

final class PinterestCollectionViewLayoutAttributes: UICollectionViewLayoutAttributes {

    var photoHeight = CGFloat(0.0)

    override func copy(with zone: NSZone?) -> Any {
        guard let copy = super.copy(with: zone) as? PinterestCollectionViewLayoutAttributes else {
            fatalError("copy failed.")
        }
        copy.photoHeight = photoHeight
        return copy
    }

    override func isEqual(_ object: Any?) -> Bool {

        if let attributes = object as? PinterestCollectionViewLayoutAttributes {

            if attributes.photoHeight == photoHeight {
                return super.isEqual(object)
            }
        }
        return false
    }
}
