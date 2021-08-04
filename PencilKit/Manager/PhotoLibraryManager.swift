//
//  StorageManager.swift
//  StorageManager
//
//  Created by Сергей Горбачёв on 04.08.2021.
//

import PhotosUI

class PhotoLibraryManager {
    
    static let shared = PhotoLibraryManager()
    
    private init() {}
    
    func saveImage(canvasView: Canvas) {
        UIGraphicsBeginImageContextWithOptions(canvasView.bounds.size, false, UIScreen.main.scale)

        canvasView.drawHierarchy(in: canvasView.bounds, afterScreenUpdates: true)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        if image != nil {
            PHPhotoLibrary.shared().performChanges {
                PHAssetChangeRequest.creationRequestForAsset(from: image!)
            } completionHandler: { (success, error) in
                success ? print("Your image is saved") : print(error?.localizedDescription ?? "No description error")
            }
        }
    }
}

