//
//  PhotoListProvider.swift
//  ios-pinterest-like-ui
//
//  Created by YukiOkudera on 2018/05/19.
//  Copyright © 2018年 YukiOkudera. All rights reserved.
//

import AVFoundation
import UIKit

final class PhotoListProvider: NSObject {
    
    var photos: [Photo] = []

    func add(photos: [Photo]) {
        self.photos = photos
    }

    func find(index: Int) -> Photo{
        return photos[index]
    }
}

// MARK: - UICollectionViewDataSource
extension PhotoListProvider: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PhotoListCell.identifier,
            for: indexPath) as? PhotoListCell else {
                fatalError("PhotoListCell is nil.")
        }
        cell.photo = photos[indexPath.row]
        return cell
    }
}

// MARK:- PinterestLayoutDelegate
extension PhotoListProvider: PinterestLayoutDelegate {

    struct FontSize {
        static let caption = CGFloat(14.0)
        static let comment = CGFloat(11.0)
    }

    struct Padding {
        static let height = CGFloat(16.0)
    }

    func collectionView(collectionView: UICollectionView,
                        heightForPhotoAtIndexPath indexPath: IndexPath,
                        withWidth width: CGFloat) -> CGFloat {

        let boundingRect = CGRect(
            x: 0,
            y: 0,
            width: width,
            height: CGFloat(MAXFLOAT)
        )
        guard let image = photos[indexPath.row].image else {
            return CGFloat(0.0)
        }

        let rect = AVMakeRect(aspectRatio: image.size, insideRect: boundingRect)
        return rect.size.height
    }

    func collectionView(collectionView: UICollectionView,
                        heightForCaptionAndCommentAtIndexPath indexPath: IndexPath,
                        withWidth width: CGFloat) -> CGFloat {

        let photo = photos[indexPath.item]
        
        let captionHeight = photo.heightForCaption(
            font: .systemFont(ofSize: FontSize.caption),
            width: width
        )
        
        let commentHeight = photo.heightForComment(
            font: .systemFont(ofSize: FontSize.comment),
            width: width
        )
        
        return Padding.height + captionHeight + commentHeight + Padding.height
    }
}
