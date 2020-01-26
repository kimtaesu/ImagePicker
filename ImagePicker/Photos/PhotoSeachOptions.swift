//
//  PhotoSeachOptions.swift
//  AssinPhotoKit
//
//  Created by tyler on 2020/01/25.
//  Copyright © 2020 tyler. All rights reserved.
//

import Foundation
import Photos

enum PhotoSeachOptions {
    case albums
    case videos
    case recentAdded
    case livePhotos
    case recents
}

extension PhotoSeachOptions {
    private var allMediaPredic: NSPredicate {
        return NSPredicate(format: "(mediaType = %ld || mediaType = %ld)", PHAssetMediaType.image.rawValue, PHAssetMediaType.video.rawValue)
    }
    func asRequest() -> PhotoRequest {
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        switch self {
        case .albums:
            fetchOptions.sortDescriptors = [NSSortDescriptor(key: "localizedTitle", ascending: true)]
            return PhotoRequest(type: .album, subtype: .any, options: fetchOptions)
        case .videos:
            fetchOptions.predicate = NSPredicate(format: "(mediaType & %ld) == 0", PHAssetMediaType.video.rawValue)
            return PhotoRequest(type: .album, subtype: .smartAlbumVideos, options: fetchOptions)
        case .recentAdded:
            return PhotoRequest(type: .album, subtype: .smartAlbumRecentlyAdded, options: fetchOptions)
        case .recents:
            fetchOptions.predicate = self.allMediaPredic
            return PhotoRequest(type: .album, subtype: .any, options: fetchOptions)
        case .livePhotos:
            return PhotoRequest(type: .album, subtype: .smartAlbumLivePhotos, options: nil)
        }
    }
}
