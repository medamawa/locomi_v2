//
//  AddPostVC+TextViewDelegate.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/15.
//

import UIKit

extension AddPostViewController: UITextViewDelegate {

    func textViewDidChange(_ textView: UITextView) {
        let hasText = !(textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
        self.navigationItem.rightBarButtonItem?.isEnabled = hasText
    }
}
