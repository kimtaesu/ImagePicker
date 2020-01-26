//
//  PHPhotoLibrary+Fetch.swift
//  AssinPhotoKit
//
//  Created by tyler on 2020/01/25.
//  Copyright © 2020 tyler. All rights reserved.
//

import UIKit
import Foundation
import Photos

public extension PHPhotoLibrary {
    // MARK: - PHPhotoLibrary+SaveImage
    func fetchMedia(options: PHFetchOptions) -> PHAssetCollection? {
        let fetchResult: PHFetchResult = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: options)
        guard let photoAlbum = fetchResult.firstObject else {
            return nil
        }
        return photoAlbum
    }
//    func findAlbum(albumName: String) -> PHAssetCollection? {
//        let fetchOptions = PHFetchOptions()
//        fetchOptions.predicate = NSPredicate(format: "title = %@", albumName)
//        let fetchResult: PHFetchResult = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)
//        guard let photoAlbum = fetchResult.firstObject else {
//            return nil
//        }
//        return photoAlbum
//    }
//
//    func getAlbums() -> [PHAssetCollection] {
//        let fetchOptions = PHFetchOptions()
//        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "localizedTitle", ascending: true)]
//        let albums = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)
//        return albums.objects(at: IndexSet(0..<albums.count))
//    }
    
//    public static func getAlbums(completion: (albums: [PHAssetCollection]) -> ()) {
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
//            let fetchOptions = PHFetchOptions()
//            fetchOptions.sortDescriptors = [NSSortDescriptor(key: "localizedTitle", ascending: true)]
//
//            let albums = PHAssetCollection.fetchAssetCollectionsWithType(.Album, subtype: .Any, options: fetchOptions)
//            let smartAlbums = PHAssetCollection.fetchAssetCollectionsWithType(.SmartAlbum, subtype: .Any, options: fetchOptions)
//
//            var result = Set<PHAssetCollection>()
//
//            [albums, smartAlbums].forEach {
//                $0.enumerateObjectsUsingBlock { collection, index, stop in
//                    guard let album = collection as? PHAssetCollection else { return }
//                    result.insert(album)
//                }
//            }
//
//            completion(albums: Array<PHAssetCollection>(result))
//        }
//    }
}
import UIKit
import Foundation
import Photos

extension PHPhotoLibrary {
    // MARK: - PHPhotoLibrary+SaveImage
    
    func savePhoto(image:UIImage, albumName:String, completion:((PHAsset?)->())? = nil) {
        func save() {
            if let album = PHPhotoLibrary.shared().findAlbum(albumName: albumName) {
                PHPhotoLibrary.shared().saveImage(image: image, album: album, completion: completion)
            } else {
                PHPhotoLibrary.shared().createAlbum(albumName: albumName, completion: { (collection) in
                    if let collection = collection {
                        PHPhotoLibrary.shared().saveImage(image: image, album: collection, completion: completion)
                    } else {
                        completion?(nil)
                    }
                })
            }
        }
        
        if PHPhotoLibrary.authorizationStatus() == .authorized {
            save()
        } else {
            PHPhotoLibrary.requestAuthorization({ (status) in
                if status == .authorized {
                    save()
                }
            })
        }
    }
    
    // MARK: - Private
    
    func findAlbum(albumName: String) -> PHAssetCollection? {
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "title = %@", albumName)
        let fetchResult : PHFetchResult = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)
        guard let photoAlbum = fetchResult.firstObject else {
            return nil
        }
        return photoAlbum
    }
    
    func createAlbum(albumName: String, completion: @escaping (PHAssetCollection?)->()) {
        var albumPlaceholder: PHObjectPlaceholder?
        PHPhotoLibrary.shared().performChanges({
            let createAlbumRequest = PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: albumName)
            albumPlaceholder = createAlbumRequest.placeholderForCreatedAssetCollection
        }, completionHandler: { success, error in
            if success {
                guard let placeholder = albumPlaceholder else {
                    completion(nil)
                    return
                }
                let fetchResult = PHAssetCollection.fetchAssetCollections(withLocalIdentifiers: [placeholder.localIdentifier], options: nil)
                guard let album = fetchResult.firstObject else {
                    completion(nil)
                    return
                }
                completion(album)
            } else {
                completion(nil)
            }
        })
    }
    
    func saveImage(image: UIImage, album: PHAssetCollection, completion:((PHAsset?)->())? = nil) {
        var placeholder: PHObjectPlaceholder?
        PHPhotoLibrary.shared().performChanges({
            let createAssetRequest = PHAssetChangeRequest.creationRequestForAsset(from: image)
            guard let albumChangeRequest = PHAssetCollectionChangeRequest(for: album),
                let photoPlaceholder = createAssetRequest.placeholderForCreatedAsset else { return }
            placeholder = photoPlaceholder
            let fastEnumeration = NSArray(array: [photoPlaceholder] as [PHObjectPlaceholder])
            albumChangeRequest.addAssets(fastEnumeration)
        }, completionHandler: { success, error in
            guard let placeholder = placeholder else {
                completion?(nil)
                return
            }
            if success {
                let assets:PHFetchResult<PHAsset> =  PHAsset.fetchAssets(withLocalIdentifiers: [placeholder.localIdentifier], options: nil)
                let asset:PHAsset? = assets.firstObject
                completion?(asset)
            } else {
                completion?(nil)
            }
        })
    }
}



extension UIImage {
    convenience init?(url: URL?) {
        guard let url = url else { return nil }
        
        do {
            let data = try Data(contentsOf: url)
            self.init(data: data)
        } catch {
            print("Cannot load image from url: \(url) with error: \(error)")
            return nil
        }
    }
}
