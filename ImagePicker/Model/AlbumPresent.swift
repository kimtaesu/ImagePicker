//
//  AlbumPresent.swift
//  ImagePicker
//
//  Created by tyler on 2020/01/25.
//  Copyright © 2020 tyler. All rights reserved.
//

import Photos

public struct AlbumPresent {
    let title: String?
    let identifier: String
    let count: Int
}

extension PHAssetCollection {
    var present: AlbumPresent {
        AlbumPresent(title: self.localizedTitle, identifier: self.localIdentifier, count: self.estimatedAssetCount)
    }
}
