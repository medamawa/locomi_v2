//
//  UITextView+Placeholder.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/09.
//

import UIKit

extension UITextView {

    private struct AssociatedKeys {
        static var placeholder = UnsafeMutablePointer<Int8>.allocate(capacity: 1)
        static var placeholderLabel = UnsafeMutablePointer<Int8>.allocate(capacity: 1)
        static var hasSetupObserver = UnsafeMutablePointer<Int8>.allocate(capacity: 1)
    }

    var placeholder: String? {
        get {
            return objc_getAssociatedObject(self, AssociatedKeys.placeholder) as? String
        }
        set {
            objc_setAssociatedObject(self, AssociatedKeys.placeholder, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)

            if let placeholderLabel = self.placeholderLabel {
                placeholderLabel.text = newValue
            } else {
                setupPlaceholderLabel()
            }
        }
    }

    private var placeholderLabel: UILabel? {
        get {
            return objc_getAssociatedObject(self, AssociatedKeys.placeholderLabel) as? UILabel
        }
        set {
            objc_setAssociatedObject(self, AssociatedKeys.placeholderLabel, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    private var hasSetupObserver: Bool {
        get {
            return objc_getAssociatedObject(self, AssociatedKeys.hasSetupObserver) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(self, AssociatedKeys.hasSetupObserver, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    private func setupPlaceholderLabel() {
        let label = UILabel()
        label.text = placeholder
        label.font = self.font ?? .systemFont(ofSize: 16)
        label.textColor = .placeholderText
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(label)
        self.placeholderLabel = label

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: self.textContainerInset.top),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.textContainerInset.left + self.textContainer.lineFragmentPadding),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -(self.textContainerInset.right + self.textContainer.lineFragmentPadding))
        ])

        if !hasSetupObserver {
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(textDidChange),
                name: UITextView.textDidChangeNotification,
                object: self
            )
            hasSetupObserver = true
        }

        updatePlaceholderVisibility()
    }

    @objc private func textDidChange() {
        updatePlaceholderVisibility()
    }

    private func updatePlaceholderVisibility() {
        placeholderLabel?.isHidden = !self.text.isEmpty
    }
}
