//
//  MediaThumbnailModel.swift
//  ImagePicker
//
//  Created by tyler on 2020/01/26.
//  Copyright © 2020 tyler. All rights reserved.
//

import UIKit
import Photos

struct ThumbnailViewModel {
    let id: PHImageRequestID
    let localIdentifier: String
    let mediaType: PHAssetMediaType
    let subMediaType: PHAssetMediaSubtype
    let duration: TimeInterval

    public init(id: PHImageRequestID, localIdentifier: String, mediaType: PHAssetMediaType, subMediaType: PHAssetMediaSubtype, duration: TimeInterval) {
        self.id = id
        self.localIdentifier = localIdentifier
        self.mediaType = mediaType
        self.subMediaType = subMediaType
        self.duration = duration
    }
}
