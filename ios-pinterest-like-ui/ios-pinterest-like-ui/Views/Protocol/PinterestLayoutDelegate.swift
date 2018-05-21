//
//  PinterestLayoutDelegate.swift
//  ios-pinterest-like-ui
//
//  Created by YukiOkudera on 2018/05/19.
//  Copyright © 2018年 YukiOkudera. All rights reserved.
//

import UIKit

protocol PinterestLayoutDelegate: class {
    
    func collectionView(
        collectionView: UICollectionView,
        heightForPhotoAtIndexPath indexPath: IndexPath,
        withWidth: CGFloat) -> CGFloat
    
    func collectionView(
        collectionView: UICollectionView,
        heightForCaptionAndCommentAtIndexPath indexPath: IndexPath,
        withWidth width: CGFloat) -> CGFloat
}
