//
//  PhotoListCell.swift
//  ios-pinterest-like-ui
//
//  Created by YukiOkudera on 2018/05/19.
//  Copyright © 2018年 YukiOkudera. All rights reserved.
//

import UIKit

final class PhotoListCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!

    var photo: Photo? {
        didSet {
            didSetPhoto(photo: photo)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func prepareForReuse() {
        imageView.image = nil
        captionLabel.text = ""
        commentLabel.text = ""
    }

    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)

        if let attributes = layoutAttributes as? PinterestCollectionViewLayoutAttributes {
            imageViewHeightConstraint.constant = attributes.photoHeight
        }
    }

    private func didSetPhoto(photo: Photo?) {
        imageView.image = photo?.image
        captionLabel.text = photo?.caption
        commentLabel.text = photo?.comment
    }
}

// MARK: - ImageCollectionViewCellType
extension PhotoListCell: ImageCollectionViewCellType {}
