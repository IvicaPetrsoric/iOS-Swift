//
//  PhotoPicker.swift
//  iOS Swift
//
//  Created by Ivica Petrsoric on 18/05/2021.
//  Copyright © 2021 ivica petrsoric. All rights reserved.
//

import SwiftUI
import PhotosUI

struct PhotoPicker: UIViewControllerRepresentable {

    @Binding var isPresented: Bool
    @Binding var selectedImage: Image?
    
    func makeUIViewController(context: Context) -> some UIViewController {
        var configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        configuration.filter = .images
        
        let controller = PHPickerViewController(configuration: configuration)
        controller.delegate = context.coordinator
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    class Coordinator: PHPickerViewControllerDelegate {
        private let parent: PhotoPicker
        
        init(_ parent: PhotoPicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            parent.isPresented = false
            
            if let itemProvider = results.first?.itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
                itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (uiimage, error) in
                    DispatchQueue.main.async {
                        guard let self = self, let uiimage = uiimage as? UIImage else { return }
                        self.parent.selectedImage = Image(uiImage: uiimage)
                    }
                }
            }
        }
    }
    
}
