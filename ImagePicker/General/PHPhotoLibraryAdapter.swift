//
//  PHPhotoLibraryAdapter.swift
//  ImagePicker
//
//  Created by tyler on 2020/01/26.
//  Copyright © 2020 tyler. All rights reserved.
//

import Foundation
import Photos

protocol PHPhotoLibraryAdaptable {
    func authorizationStatus() -> PHAuthorizationStatus
}
class PHPhotoLibraryAdapter: PHPhotoLibraryAdaptable {
    func authorizationStatus() -> PHAuthorizationStatus {
        return PHPhotoLibrary.authorizationStatus()
    }
}
