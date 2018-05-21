//
//  PhotoDataSource.swift
//  ios-pinterest-like-ui
//
//  Created by YukiOkudera on 2018/05/19.
//  Copyright © 2018年 YukiOkudera. All rights reserved.
//

import UIKit

final class PhotoDataSource {

    static let fileName = "photos"
    static let fileType = "plist"

    struct plistKeys {
        static let caption = "caption"
        static let comment = "comment"
        static let image = "image"
    }

    static func loadPhotos() -> [Photo] {

        var result = [Photo]()

        guard
            let filePath =  Bundle.main.path(forResource: fileName, ofType: fileType),
            let contentsOfFile = NSDictionary(contentsOfFile: filePath),
            let photos = contentsOfFile.object(forKey: fileName) as? NSArray
            else {
                return result
        }

        photos.forEach {

            guard let dic = $0 as? NSDictionary else {
                return
            }

            var photo = Photo()
            photo.caption = dic.object(forKey: plistKeys.caption) as? String ?? ""
            photo.comment = dic.object(forKey: plistKeys.comment) as? String ?? ""
            photo.image = UIImage(named:
                dic.object(forKey: plistKeys.image) as? String ?? ""
            )
            result.append(photo)
        }
        return result
    }
}
