//
//  ImagePickerManager.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/20.
//

import UIKit
import PhotosUI

final class ImagePickerManager: NSObject, PHPickerViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    weak var parentVC: UIViewController?
    var completion: ((UIImage) -> Void)?

    init(parentVC: UIViewController) {
        self.parentVC = parentVC
    }

    // MARK: - Create UIMenu
    func getMenu() -> UIMenu {
        let menuItems = [
            UIAction(title: "Camera", image: UIImage(systemName: "camera.fill")) { _ in
                self.pickUsingCamera()
            },
            UIAction(title: "Gallery", image: UIImage(systemName: "photo.on.rectangle")) { _ in
                self.pickPhotoFromGallery()
            }
        ]
        return UIMenu(title: "Select source", children: menuItems)
    }

    // MARK: - Camera
    func pickUsingCamera() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            let alert = UIAlertController(title: "Camera not available", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            parentVC?.present(alert, animated: true)
            return
        }

        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.allowsEditing = true
        picker.delegate = self
        parentVC?.present(picker, animated: true)
    }

    // MARK: - Gallery
    func pickPhotoFromGallery() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1

        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        parentVC?.present(picker, animated: true)
    }

    // MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        parentVC?.dismiss(animated: true)
        if let image = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage {
            completion?(image)
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        parentVC?.dismiss(animated: true)
    }

    // MARK: - PHPicker Delegate
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        parentVC?.dismiss(animated: true)
        guard let provider = results.first?.itemProvider else { return }

        if provider.canLoadObject(ofClass: UIImage.self) {
            provider.loadObject(ofClass: UIImage.self) { [weak self] image, _ in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    if let uiImage = image as? UIImage {
                        self.completion?(uiImage)
                    }
                }
            }
        }
    }
}
