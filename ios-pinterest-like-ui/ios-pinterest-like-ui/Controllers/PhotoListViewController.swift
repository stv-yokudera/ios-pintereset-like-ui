//
//  PhotoListViewController.swift
//  ios-pinterest-like-ui
//
//  Created by YukiOkudera on 2018/05/19.
//  Copyright © 2018年 YukiOkudera. All rights reserved.
//

import UIKit

final class PhotoListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    private let dataProvider = PhotoListProvider()
    var imageTransitionDelegate: ImageTransitionDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let photos = PhotoDataSource.loadPhotos()
        dataProvider.add(photos: photos)
    }

    private func setup() {
        collectionView.dataSource = dataProvider
        collectionView.delegate = self

        let flowLayout = PinterestCollectionViewLayout()
        flowLayout.delegate = dataProvider
        collectionView.collectionViewLayout = flowLayout
        imageTransitionDelegate = ImageTransitionDelegate()
    }
}

// MARK: - UICollectionViewDelegate
extension PhotoListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let identifier = "PhotoDetailViewController"
        let vc = UIStoryboard.viewController(
            storyboardName: identifier,
            identifier: identifier
            ) as! PhotoDetailViewController
        
        vc.transitioningDelegate = imageTransitionDelegate
        vc.image = dataProvider.find(index: indexPath.row).image
        present(vc, animated: true, completion: nil)
    }
}

// MARK: - ImageSourceTransitionType
extension PhotoListViewController: ImageSourceTransitionType {}
