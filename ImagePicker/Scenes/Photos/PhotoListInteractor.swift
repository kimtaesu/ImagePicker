//
//  PhotoListInteractor.swift
//  ImagePicker
//
//  Created by tyler on 2020/01/26.
//  Copyright © 2020 tyler. All rights reserved.
//

import Foundation

protocol PhotoListBusinessLogic {
    func fetchPhotos()
}

final class PhotoListInteractor: PhotoListBusinessLogic {
    
    private let presenter: PhotoListPresentationLogic
    private let photoAdapter: PHPhotoLibraryAdaptable
    
    init(
        presenter: PhotoListPresentationLogic,
        photoAdapter: PHPhotoLibraryAdaptable
    ) {
        self.presenter = presenter
        self.photoAdapter = photoAdapter
    }
    func fetchPhotos() {
        // ViewController 에 의해서 호출됩니다.
        let status = self.photoAdapter.authorizationStatus()
        DebugLog("fetchPhotos: status \(status)")
        switch status {
        case .denied:
            self.presenter.presentAlertDenied()
        case .authorized:
            self.presenter.presentFetchedPhotos()
        case .notDetermined:
            break
        case .restricted:
            self.presenter.presentAlertRestriced()
        }
    }
}
