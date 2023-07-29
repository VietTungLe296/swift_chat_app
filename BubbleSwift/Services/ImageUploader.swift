//
//  ImageUploader.swift
//  BubbleSwift
//
//  Created by Le Viet Tung on 29/07/2023.
//

import Foundation
import FirebaseStorage
import UIKit

struct ImageUploader {
    static func uploadImage(image: UIImage, completion: @escaping(String) -> Void) {
        guard let data = image.jpegData(compressionQuality: 0.5) else { return}
        
        let fileName = NSUUID().uuidString
        let storageRef = Storage.storage().reference(withPath: "/profile_images/\(fileName)")
        
        storageRef.putData(data, metadata: nil) { _, error in
            if let error {
                print("Error uploading image to Firebase: \(error.localizedDescription)")
                return
            }
            print("Image successfully uploaded to Firebase!")
            
            storageRef.downloadURL { url, error in
                guard let imageUrl = url?.absoluteString else { return }
                completion(imageUrl)
            }
        }
    }
}
