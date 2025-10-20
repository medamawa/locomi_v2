//
//  FirestorageManager.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/20.
//

import UIKit
import FirebaseStorage

class FirestorageManager {
    static let shared = FirestorageManager()
    private let storage = Storage.storage()

    private init() {}

    /// Upload image to Firebase Storage and return its URL
    func uploadImage(_ image: UIImage, folder: String, uid: String, completion: @escaping (Result<URL, Error>) -> Void) {
        // TODO: refactor compressing process
        let resizedImage = image.resized()
        guard let jpegData = resizedImage.jpegData(compressionQuality: 0.8) else {
            completion(.failure(NSError(domain: "ImageConversionError", code: -1)))
            return
        }

        let fileName = "\(UUID().uuidString).jpg"
        let imageRef = storage.reference().child(folder).child(uid).child(fileName)

        imageRef.putData(jpegData) { metadata, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            imageRef.downloadURL { url, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let url = url else {
                    completion(.failure(NSError(domain: "URLNotFound", code: -1)))
                    return
                }
                completion(.success(url))
            }
        }
    }
}
