//
//  ViewController.swift
//  Example
//
//  Created by Kristof Kalai on 2022. 12. 08..
//

import ColorChangingLabel
import UIKit

final class ViewController: UIViewController {
    private let label = ColorChangingLabel()
    private var currentColor = UIColor.red

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabel()
    }
}

extension ViewController {
    private func setupLabel() {
        label.set(color: currentColor)
        label.configureLabel {
            $0.text = "Tap me to change color!"
            $0.font = $0.font.withSize(22)
            $0.numberOfLines = .zero
        }
        view.addSubview(label)
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 24).isActive = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapLabel)))
    }

    @objc private func didTapLabel() {
        label.change(toColor: currentColor == .blue ? .red : .blue, duration: 2) { [weak self] in
            guard $0 else { return }
            self?.label.configureLabel { _ in
                $0.text = "Tap me to change color!"
            }
        }
        label.configureLabel { label in
            label.text = "You can tap me, even though it's in progress..."
        }
        currentColor = currentColor == .blue ? .red : .blue
    }
}
