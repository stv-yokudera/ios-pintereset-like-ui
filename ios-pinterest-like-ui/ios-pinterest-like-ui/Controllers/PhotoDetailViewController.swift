//
//  PhotoDetailViewController.swift
//  ios-pinterest-like-ui
//
//  Created by YukiOkudera on 2018/05/19.
//  Copyright © 2018年 YukiOkudera. All rights reserved.
//

import UIKit

final class PhotoDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var image: UIImage?
    
    @IBAction func didTapDissmiss(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

extension PhotoDetailViewController: ImageDestinationTransitionType {}
