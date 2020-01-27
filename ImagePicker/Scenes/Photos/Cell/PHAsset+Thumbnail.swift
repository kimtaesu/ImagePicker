//
//  PHAsset+Thumbnail.swift
//  ImagePicker
//
//  Created by tyler on 2020/01/26.
//  Copyright © 2020 tyler. All rights reserved.
//

import Photos

extension PHAsset {
    func mapThumbnail(id: PHImageRequestID) -> ThumbnailViewModel {
        ThumbnailViewModel(
            id: id,
            localIdentifier: self.localIdentifier,
            mediaType: self.mediaType,
            subMediaType: self.mediaSubtypes,
            duration: self.duration)
    }
}
