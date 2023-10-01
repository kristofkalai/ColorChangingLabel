//
//  ColorChangingLabel.swift
//
//
//  Created by Kristof Kalai on 2022. 12. 08..
//

import UIKit
import LayerAnimation

public final class ColorChangingLabel: UIView {
    private let label = ColorChangingLabelContentLabel(textColor: .black)
    private let sizeProposerLabel = ColorChangingLabelContentLabel(textColor: .clear)

    private class ColorChangingLabelContentLabel: UILabel {
        private var _textColor: UIColor = .black
        private var textColorShouldNotChange = false
        fileprivate var invalidatedIntrinsicContentSize: (() -> Void)?

        override var textColor: UIColor! {
            willSet {
                if textColorShouldNotChange {
                    assertionFailure("The textColor of the label shouldn't be modified. It's alpha channel is the main point. It will be reseted to .black.")
                }
            }
            didSet {
                if textColorShouldNotChange {
                    textColorShouldNotChange = false
                    textColor = _textColor
                    textColorShouldNotChange = true
                    assertionFailure("The textColor of the label shouldn't be modified. It's alpha channel is the main point. It's reseted to .black.")
                }
            }
        }

        init(textColor: UIColor) {
            super.init(frame: .zero)
            self.textColor = textColor
            textColorShouldNotChange = true
        }

        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override func invalidateIntrinsicContentSize() {
            super.invalidateIntrinsicContentSize()
            invalidatedIntrinsicContentSize?()
        }
    }

    public init() {
        super.init(frame: .zero)

        translatesAutoresizingMaskIntoConstraints = false
        set(color: .black)

        addSubview(label)
        mask = label
        label.invalidatedIntrinsicContentSize = { [weak self] in
            self?.invalidateIntrinsicContentSize()
        }

        addSubview(sizeProposerLabel)
        sizeProposerLabel.translatesAutoresizingMaskIntoConstraints = false
        sizeProposerLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        sizeProposerLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        sizeProposerLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        sizeProposerLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ColorChangingLabel {
    public override var bounds: CGRect {
        didSet {
            label.frame = bounds
        }
    }

    public override var intrinsicContentSize: CGSize {
        sizeProposerLabel.intrinsicContentSize
    }
}

extension ColorChangingLabel {
    public func set(color: UIColor) {
        layer.backgroundColor = color.cgColor
    }

    public func change(toColor: UIColor,
                       duration: TimeInterval,
                       timingFunction: CAMediaTimingFunction = .init(name: .linear),
                       repeatCount: Float = .zero,
                       autoreverses: Bool = false,
                       completion: @escaping (Bool) -> Void) {
        layer.animate(to: CALayer.LayerAnimatable.backgroundColor(toColor),
                      with: duration,
                      timingFunction: timingFunction,
                      repeatCount: repeatCount,
                      autoreverses: autoreverses,
                      completion: completion)
    }

    public func change(toColor: UIColor,
                       duration: TimeInterval,
                       timingFunction: CAMediaTimingFunction = .init(name: .linear),
                       repeatCount: Float = .zero,
                       autoreverses: Bool = false,
                       completion: @escaping () -> Void = { }) {
        change(toColor: toColor, duration: duration, timingFunction: timingFunction, repeatCount: repeatCount, autoreverses: autoreverses) { _ in completion() }
    }

    public func configureLabel(_ label: (UILabel) -> Void) {
        label(self.label)
        label(sizeProposerLabel)
    }
}
