//
//  CAAnimation+Extensions.swift
//  
//
//  Created by Kristof Kalai on 2022. 12. 08..
//

import UIKit

extension CAAnimation {
    final private class AnimationDelegate: NSObject, CAAnimationDelegate {
        fileprivate var didStartCallback: () -> Void = { }
        fileprivate var didStopCallback: (Bool) -> Void = { _ in }

        fileprivate func animationDidStart(_ anim: CAAnimation) {
            didStartCallback()
        }

        fileprivate func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
            didStopCallback(flag)
        }
    }

    @discardableResult func start(callback: @escaping () -> Void) -> CAAnimationDelegate {
        if let delegate = delegate as? AnimationDelegate {
            delegate.didStartCallback = callback
            return delegate
        } else {
            let delegate = AnimationDelegate()
            delegate.didStartCallback = callback
            self.delegate = delegate
            return delegate
        }
    }

    @discardableResult func completion(callback: @escaping (Bool) -> Void) -> CAAnimationDelegate {
        if let delegate = delegate as? AnimationDelegate {
            delegate.didStopCallback = callback
            return delegate
        } else {
            let delegate = AnimationDelegate()
            delegate.didStopCallback = callback
            self.delegate = delegate
            return delegate
        }
    }

    @discardableResult func completion(callback: @escaping () -> Void) -> CAAnimationDelegate {
        completion { _ in callback() }
    }
}
