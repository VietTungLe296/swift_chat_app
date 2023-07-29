//
//  ImagePicker.swift
//  BubbleSwift
//
//  Created by Le Viet Tung on 29/07/2023.
//

import SwiftUI
import PhotosUI

@MainActor
class ImagePicker: ObservableObject {
    @Published var image: UIImage?
    
    @Published var imageSelection: PhotosPickerItem? {
        didSet {
            if let imageSelection {
                Task {
                    try await loadTransferrable(from: imageSelection)
                }
            }
        }
    }
    
    func loadTransferrable(from imageSelection: PhotosPickerItem?) async throws {
        do {
            if let data = try await imageSelection?.loadTransferable(type: Data.self) {
                if let image = UIImage(data: data) {
                    self.image = image
                }
            }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}
