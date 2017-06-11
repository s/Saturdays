//
//  IssueDetailsAnimator.swift
//  Saturdays
//
//  Created by Said Ozcan on 05/06/2017.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import UIKit

class IssueDetailsAnimator: NSObject {
    var presenting = true
    var sourceRect = CGRect.zero
    var sourceView : UIView?
    
    fileprivate func createTransitionView(with sourceView:UIView) -> UIView {
        let view = UIView(frame: sourceView.frame)
        view.addSubview(sourceView)
        view.backgroundColor = UIColor.white
        return view
    }
}

extension IssueDetailsAnimator : UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return UIDefines.issueDetailsTransitionDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let sourceView = sourceView,
            let toVC = transitionContext.viewController(forKey: .to) as? IssueDetailsView,
            let fromVC = transitionContext.viewController(forKey: .from),
            let snapshot = toVC.view.snapshotView(afterScreenUpdates: true)
        else {
            transitionContext.completeTransition(true)
            return
        }
        
        let containerView = transitionContext.containerView
        let finalFrameForImageView = toVC.imageViewFrame
        let animationDuration = transitionDuration(using: transitionContext)
        
        
        containerView.addSubview(fromVC.view)
        containerView.addSubview(toVC.view)
        
        let animations = {
            sourceView.frame = finalFrameForImageView
        }
        
        let completion : (Bool) -> Void = { (completed) in
            transitionContext.completeTransition(true)
        }
        UIView.animateKeyframes(withDuration: animationDuration,
                                delay: 0.0,
                                options: UIViewKeyframeAnimationOptions.allowUserInteraction,
                                animations: animations,
                                completion: completion)
    }
}
