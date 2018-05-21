//
//  ImageDismissedAnimator.swift
//  ios-pinterest-like-ui
//
//  Created by YukiOkudera on 2018/05/19.
//  Copyright © 2018年 YukiOkudera. All rights reserved.
//

import UIKit

final class ImageDismissedAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        let containerView = transitionContext.containerView
        let animationDuration = transitionDuration(using: transitionContext)

        guard
            let fromVC = transitionContext.viewController(forKey: .from) as? ImageDestinationTransitionType,
            let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from) else {
                return
        }

        // create snapshot
        let snapshot = fromVC.imageView.snapshotView(afterScreenUpdates: false)
        snapshot?.frame = containerView.convert(fromVC.imageView.frame,
                                                to: fromVC.imageView.superview)
        snapshot?.autoresizingMask = [.flexibleHeight, .flexibleWidth, .flexibleTopMargin, .flexibleBottomMargin]
        fromVC.imageView.alpha = 0.0

        guard
            let toVC = transitionContext.viewController(forKey: .to) as? ImageSourceTransitionType,
            let toView = transitionContext.view(forKey: .to) else {
                return
        }

        containerView.insertSubview(toView, belowSubview: fromView)

        guard let selectedIndexPath = toVC.collectionView.indexPathsForSelectedItems?.first else {
            return
        }
        let selectedCell = toVC.collectionView.cellForItem(at: selectedIndexPath) as! ImageCollectionViewCellType
        selectedCell.imageView.alpha = 0.0
        selectedCell.imageView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)

        toVC.collectionView.frame = transitionContext.finalFrame(for: toVC as! UIViewController)

        // create animationView
        let animationView = UIView(frame: containerView.convert(fromVC.imageView.frame,
                                                                to: toVC.collectionView.superview))
        animationView.clipsToBounds = true
        animationView.addSubview(snapshot!)
        containerView.addSubview(animationView)
        
        // create whiteView
        let whiteView = UIView(frame: fromVC.imageView.frame)
        whiteView.backgroundColor = .white
        containerView.insertSubview(whiteView, belowSubview: animationView)
        
        UIView.animateKeyframes(
            withDuration: animationDuration,
            delay: 0.0,
            options: .calculationModeLinear,
            animations: {

                UIView.addKeyframe(
                    withRelativeStartTime: 0.0,
                    relativeDuration: 1.0,
                    animations: {

                        fromVC.imageView.alpha = 0.0
                        animationView.frame = containerView.convert(
                            selectedCell.imageView.frame,
                            from: selectedCell.imageView.superview
                        )
                        whiteView.alpha = 0.0
                        selectedCell.imageView.alpha = 1.0
                })

                UIView .addKeyframe(
                    withRelativeStartTime: 0.95,
                    relativeDuration: 0.05,
                    animations: {
                        selectedCell.imageView.transform = .identity
                        snapshot?.alpha = 0.0
                })

        }) { _ in
            
            whiteView.removeFromSuperview()
            snapshot?.removeFromSuperview()
            animationView.removeFromSuperview()
            fromVC.imageView.isHidden = false
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}

