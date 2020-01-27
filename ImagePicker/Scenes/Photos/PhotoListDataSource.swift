//
//  PhotoListDataSource.swift
//  ImagePicker
//
//  Created by tyler on 2020/01/26.
//  Copyright © 2020 tyler. All rights reserved.
//

import Photos
import UIKit

final class PhotoListDataSource: NSObject, UICollectionViewDataSource {

    private var result = PHFetchResult<PHAssetCollection>()
    private let adapter: PHPhotoLibraryAdaptable
    init(adapter: PHPhotoLibraryAdaptable) {
        self.adapter = adapter
    }
    func setSectionModel(_ result: PHFetchResult<PHAssetCollection>) {
        self.result = result
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        DebugLog("item count: \(self.result.count)")
        return self.result.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(for: ThumbnailCell.self, indexPath: indexPath)
        let collection: PHAssetCollection = self.result.object(at: indexPath.item)
        if let asset = self.adapter.fetchAssets(in: collection, options: nil).firstObject {
            let id = self.adapter.requestImage(
                for: asset,
                targetSize: cell.frame.size,
                contentMode: .aspectFill,
                options: nil) { image, info in
                    cell.setImage(image)
            }
            cell.configCell(asset.mapThumbnail(id: id))
        }
        return cell
    }
    
    func cancelImage(_ id: IMAGE_REQUEST_ID) {
        self.data
    }
}
