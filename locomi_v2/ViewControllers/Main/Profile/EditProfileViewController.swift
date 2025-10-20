//
//  EditProfileViewController.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/20.
//

import UIKit

class EditProfileViewController: UIViewController {

    var coordinator: ProfileCoordinator?
    var delegate: EditProfileViewControllerDelegate?

    let editProfileView = EditProfileView()
    var imagePickerManager: ImagePickerManager!

    private var user: User
    private var pickedImage: UIImage?

    init(user: User) {
        self.user = user
        self.pickedImage = nil
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        view = editProfileView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        setupActions()
        setupUserInfo()
    }

    // MARK: - Setup
    func setupActions() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(didTapSaveButton))

        imagePickerManager = ImagePickerManager(parentVC: self)
        imagePickerManager.completion = { [weak self] image in
            guard let self = self else { return }
            self.pickedImage = image
            self.editProfileView.imageProfile.image = image
        }
        let tapGestureOnProfileImage = UITapGestureRecognizer(target: self, action: #selector(onProfileImageTapped))
        editProfileView.imageProfile.isUserInteractionEnabled = true
        editProfileView.imageProfile.addGestureRecognizer(tapGestureOnProfileImage)
    }

    func setupUserInfo() {
        Task {
            editProfileView.imageProfile.image = await user.loadProfileImage()
        }
        editProfileView.textFieldName.text = user.displayName
        editProfileView.textFieldBio.text = user.bio
    }

    // MARK: - Actions
    @objc func didTapSaveButton() {
        guard let displayName = editProfileView.textFieldName.text?.trimmed else {
            showErrorAlert(message: "Please fill in all required fields")
            return
        }

        if displayName.isBlank {
             showErrorAlert(message: "Display name cannot be empty")
             return
         }

        func finishSaving(profileImageURL: URL?) {
            let updatedUser = User(
                uid: self.user.uid,
                displayName: displayName,
                username: self.user.username,
                email: self.user.email,
                profileImageURL: profileImageURL,
                bio: editProfileView.textFieldBio.text
            )

            // TODO: update firestore
            delegate?.editProfileViewController(self, didUpdate: updatedUser)
            dismiss(animated: true)
        }

        if let profileImage = pickedImage {
            FirestorageManager.shared.uploadImage(profileImage, folder: "imageUsers", uid: self.user.uid) { result in
                switch result {
                    case .success(let url):
                    print("Successfully uploaded image: \(url.absoluteString)")
                    DispatchQueue.main.async {
                        finishSaving(profileImageURL: url)
                    }
                case .failure(let error):
                    print("Error uploading image: \(error)")
                    DispatchQueue.main.async {
                        self.showErrorAlert(message: "Failed to upload image. Please try again.")
                    }
                }
            }
        } else {
            finishSaving(profileImageURL: nil)
        }
    }

    @objc func onProfileImageTapped() {
        let alert = UIAlertController(title: "Select source", message: nil, preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.imagePickerManager.pickUsingCamera()
        }))
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.imagePickerManager.pickPhotoFromGallery()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        present(alert, animated: true)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
