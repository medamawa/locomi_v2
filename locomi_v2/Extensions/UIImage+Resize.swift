//
//  UIImage+Resize.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/20.
//

import UIKit

extension UIImage {
    func resized(maxSize: CGFloat = 1024) -> UIImage {
        let aspectRatio = size.width / size.height
        var newSize: CGSize
        if aspectRatio > 1 {
            newSize = CGSize(width: maxSize, height: maxSize / aspectRatio)
        } else {
            newSize = CGSize(width: maxSize * aspectRatio, height: maxSize)
        }

        let renderer = UIGraphicsImageRenderer(size: newSize)
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
}
