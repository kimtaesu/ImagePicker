//
//  PhotoListInteractor.swift
//  ImagePicker
//
//  Created by tyler on 2020/01/26.
//  Copyright © 2020 tyler. All rights reserved.
//

import Foundation

protocol PhotoListBusinessLogic {
    func fetchPhotos(options: PhotoFetchOptions)
}

final class PhotoListInteractor: PhotoListBusinessLogic {
    
    private let presenter: PhotoListPresentationLogic
    private let photoAdapter: PHPhotoLibraryAdaptable
    private let worker: PhotoListWorkerType
    init(
        presenter: PhotoListPresentationLogic,
        photoAdapter: PHPhotoLibraryAdaptable
    ) {
        self.worker = PhotoListWorker(adapter: photoAdapter)
        self.presenter = presenter
        self.photoAdapter = photoAdapter
    }
    func fetchPhotos(options: PhotoFetchOptions) {
        // ViewController 에 의해서 호출됩니다.
        let status = self.photoAdapter.authorizationStatus()
        DebugLog("fetchPhotos: status \(status)")
        switch status {
        case .denied:
            self.presenter.presentAlertDenied()
        case .authorized:
            self._fetchPhotos(options)
        case .notDetermined:
            photoAdapter.requestAuthorization { newStatus in
                if status == newStatus {
                    return
                }
                self._fetchPhotos(options)
            }
        case .restricted:
            self.presenter.presentAlertRestriced()
        default:
            self.presenter.presentAlertRestriced()
        }
    }
    private func _fetchPhotos(_ options: PhotoFetchOptions) {
        self.presenter.presentFetchedPhotos(self.worker.fetchPhotos(options: options))
    }
}
