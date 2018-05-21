//
//  Photo.swift
//  ios-pinterest-like-ui
//
//  Created by YukiOkudera on 2018/05/19.
//  Copyright © 2018年 YukiOkudera. All rights reserved.
//

import UIKit

struct Photo {
    var caption = ""
    var comment = ""
    var image: UIImage?

    func heightForCaption(font: UIFont, width: CGFloat) -> CGFloat {
        return caption.height(font: font, width:width)
    }

    func heightForComment(font: UIFont, width: CGFloat) -> CGFloat {
        return comment.height(font: font, width:width)
    }
}

private extension String {

    private var nsString: NSString {
        return (self as NSString)
    }

    func height(font: UIFont, width: CGFloat) -> CGFloat {
        let rect = nsString.boundingRect(
            with: CGSize(width: width, height: CGFloat(MAXFLOAT)),
            options: .usesLineFragmentOrigin,
            attributes: [.font: font],
            context: nil
        )
        
        return ceil(rect.height)
    }
}
