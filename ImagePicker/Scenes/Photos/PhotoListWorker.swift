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

protocol PhotoListWorkerType: class {
    func fetchPhotos(options: PhotoFetchOptions) -> PHFetchResult<PHAssetCollection>
}

final class PhotoListWorker: PhotoListWorkerType {
    
    private let adapter: PHPhotoLibraryAdaptable
    
    init(adapter: PHPhotoLibraryAdaptable) {
        self.adapter = adapter
    }
    
    func fetchPhotos(options: PhotoFetchOptions) -> PHFetchResult<PHAssetCollection> {
        let request = options.asRequest()
        let result = self.adapter.fetchAssetCollections(with: request.type, subtype: request.subtype, options: request.options)
        return result
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

