//
//  ImageTransitionProtocol.swift
//  ios-pinterest-like-ui
//
//  Created by YukiOkudera on 2018/05/19.
//  Copyright © 2018年 YukiOkudera. All rights reserved.
//

import UIKit

protocol ImageSourceTransitionType {
    var collectionView: UICollectionView! { get }
}

protocol ImageDestinationTransitionType {
    var imageView: UIImageView! { get }
}

protocol ImageCollectionViewCellType {
    var imageView: UIImageView! { get }

    static var identifier: String { get }
}

extension ImageCollectionViewCellType {
    static var identifier: String {
        get {
            return String(describing: self)
        }
    }
}
