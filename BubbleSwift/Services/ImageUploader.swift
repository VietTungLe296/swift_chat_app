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
    static func uploadImage(image: UIImage) async throws -> String {
        guard let data = image.jpegData(compressionQuality: 0.5) else {
            throw NSError(domain: "ImageUploader", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to get image data"])
        }
        
        let fileName = NSUUID().uuidString
        let storageRef = Storage.storage().reference(withPath: "/profile_images/\(fileName)")
        
        do {
            let _ = try await storageRef.putDataAsync(data, metadata: nil)
            print("Image successfully uploaded to Firebase!")
            
            let url = try await storageRef.downloadURL()
            return url.absoluteString
        } catch {
            print("Error uploading image to Firebase: \(error.localizedDescription)")
            throw error
        }
    }
}




