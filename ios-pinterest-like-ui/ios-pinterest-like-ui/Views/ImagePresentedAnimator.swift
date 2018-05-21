//
//  ImagePresentedAnimator.swift
//  ios-pinterest-like-ui
//
//  Created by YukiOkudera on 2018/05/19.
//  Copyright © 2018年 YukiOkudera. All rights reserved.
//

import UIKit

final class ImagePresentedAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        let containerView = transitionContext.containerView
        let animationDuration = transitionDuration(using: transitionContext)

        guard
            let toView = transitionContext.view(forKey: .to),
            let toVC = transitionContext.viewController(forKey: .to) as? ImageDestinationTransitionType else {
                return
        }

        guard let fromVC = transitionContext.viewController(forKey: .from) as? ImageSourceTransitionType else {
            return
        }

        guard
            let selectedIndexPath = fromVC.collectionView.indexPathsForSelectedItems?.first,
            let selectedCell = fromVC.collectionView.cellForItem(at: selectedIndexPath) as? ImageCollectionViewCellType else {
                return
        }

        // set image
        toVC.imageView.image = selectedCell.imageView.image

        let finalFrame = toView.frame

        toView.clipsToBounds = true
        containerView.addSubview(toView)

        let selectedCellFrame = containerView.convert(
            selectedCell.imageView.frame,
            from: selectedCell.imageView.superview
        )

        // create animationView
        let animationView = UIView(frame: selectedCellFrame)
        animationView.backgroundColor = .clear
        animationView.clipsToBounds = true

        let imageView = UIImageView(image: selectedCell.imageView.image)
        imageView.frame = CGRect(x: 0.0, y: 0.0, width: selectedCellFrame.width, height: selectedCellFrame.height)
        imageView.contentMode = toVC.imageView.contentMode
        imageView.autoresizingMask = [.flexibleHeight, .flexibleWidth, .flexibleTopMargin, .flexibleBottomMargin]

        animationView.addSubview(imageView)
        containerView.addSubview(animationView)

        // create whiteView
        let whiteView = UIView(frame: fromVC.collectionView.frame)
        whiteView.backgroundColor = .white
        containerView.insertSubview(whiteView, belowSubview: animationView)

        UIView.animate(withDuration: animationDuration,
                       delay: 0.0,
                       options: .curveEaseOut,
                       animations: {
                        animationView.frame = finalFrame

        }, completion: { _ in

            // アニメーションが完了したら、animationView, whiteViewを削除する
            animationView.removeFromSuperview()
            whiteView.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
