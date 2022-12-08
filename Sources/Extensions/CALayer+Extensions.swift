//
//  CALayer+Extensions.swift
//  
//
//  Created by Kristof Kalai on 2022. 12. 08..
//

import UIKit

extension CALayer {
    private var currentLayer: Self {
        presentation() ?? self
    }

    private func addPropertyAnimation(_ animation: CAPropertyAnimation) {
        if animation.duration < .ulpOfOne {
            animation.duration = .ulpOfOne
        }
        animation.beginTime = CACurrentMediaTime()
        add(animation, forKey: animation.keyPath)
    }

    func animateBackground(to color: CGColor,
                           with duration: TimeInterval = .ulpOfOne,
                           timingFunction: CAMediaTimingFunction = .init(name: .linear),
                           repeatCount: Float = .zero,
                           autoreverses: Bool = false,
                           completion: @escaping (Bool) -> Void = { _ in }) {
        removeAnimation(forKey: #keyPath(CALayer.backgroundColor))
        model().setValue(currentLayer.value(forKeyPath: #keyPath(CALayer.backgroundColor)),
                         forKeyPath: #keyPath(CALayer.backgroundColor))
        let animation = CABasicAnimation(keyPath: #keyPath(CALayer.backgroundColor))
        CATransaction.commit {
            animation.fromValue = currentLayer.backgroundColor
            animation.toValue = color as Any
            animation.duration = max(duration, .zero)
            animation.timingFunction = timingFunction
            animation.repeatCount = repeatCount
            animation.autoreverses = autoreverses
            animation.isRemovedOnCompletion = false
            animation.fillMode = .forwards
            animation.completion { [weak self] didFinish in
                if didFinish {
                    self?.model().setValue(color as Any, forKeyPath: #keyPath(CALayer.backgroundColor))
                    self?.removeAnimation(forKey: #keyPath(CALayer.backgroundColor))
                }
                completion(didFinish)
            }
            removeAnimation(forKey: #keyPath(CALayer.backgroundColor))
            addPropertyAnimation(animation)
        }
    }
}
