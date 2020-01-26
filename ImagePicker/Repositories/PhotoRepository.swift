//
//  PhotoRepository.swift
//  ImagePicker
//
//  Created by tyler on 2020/01/25.
//  Copyright © 2020 tyler. All rights reserved.
//

import Foundation
import Photos

struct PhotoSection {

}

protocol PhotoRepositoryType: class {
    func fetchPhotos(options: PhotoSeachOptions, closure: @escaping (Result<PhotoSection, Error>) -> Void)
}

final class PhotoRepository: PhotoRepositoryType {
    func fetchPhotos(options: PhotoSeachOptions, closure: @escaping (Result<PhotoSection, Error>) -> Void) {
        self._fetchPhotos(options: options, closure: closure)
    }
    
    private func _fetchPhotos(
        options: PhotoSeachOptions,
        closure: @escaping (Result<PhotoSection, Error>) -> Void,
        isRequested: Bool = false
    ) {
            let status = PHPhotoLibrary.authorizationStatus()
            switch status {
            case .authorized:
                let request = options.asRequest()
                let result = PHAssetCollection.fetchAssetCollections(with: request.type, subtype: request.subtype, options: request.options)
            case .denied:
                closure(Result.failure(PhotoError.denied))
            case .notDetermined:
                PHPhotoLibrary.requestAuthorization { status in
                    if isRequested {
                        closure(Result.failure(PhotoError.requestDuplicated))
                    } else {
                        self._fetchPhotos(options: options, closure: closure, isRequested: true)
                    }
                }
            case .restricted:
                closure(Result.failure(PhotoError.restricted))
            }
        }
}

enum PhotoError: Error {
    case denied
    case restricted
    case requestDuplicated
}

struct PhotoRequest {
    let type: PHAssetCollectionType
    let subtype: PHAssetCollectionSubtype
    let options: PHFetchOptions?
}

