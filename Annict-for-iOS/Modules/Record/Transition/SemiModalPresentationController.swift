//
//  SemiModalPresentationController.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/10/29.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import UIKit

final class SemiModalPresentationController: UIPresentationController {
    private lazy var overlay: UIView = {
        guard let containerView = containerView else { return UIView() }
        let view = UIView(frame: containerView.bounds)
        view.backgroundColor = .black
        view.alpha = 0
        view.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                         action: #selector(tappedOverlay(_:))))
        return view
    }()
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else { return .zero }
        return CGRect(x: 0, y: 400, width: containerView.bounds.width, height: containerView.bounds.height - 400)
    }
    
    override func presentationTransitionWillBegin() {
        containerView?.insertSubview(overlay, at: 0)
        
        presentedViewController.view.layer.cornerRadius = 12
        
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { [weak self] context in
            self?.overlay.alpha = 0.35
        }, completion: nil)
    }
    
    override func dismissalTransitionWillBegin() {
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { [weak self] context in
            self?.overlay.alpha = 0
        }, completion: nil)
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            overlay.removeFromSuperview()
        }
    }
    
    @objc private func tappedOverlay(_ sender: UITapGestureRecognizer) {
        presentedViewController.dismiss(animated: true, completion: nil)
    }
}
