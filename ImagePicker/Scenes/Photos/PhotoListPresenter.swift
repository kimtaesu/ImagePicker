//
//  PhotoListPresentation.swift
//  ImagePicker
//
//  Created by tyler on 2020/01/25.
//  Copyright © 2020 tyler. All rights reserved.
//

import Foundation

protocol PhotoListPresentationLogic {
    func presentFetchedPhotos()
    func presentAlertDenied()
    func presentAlertRestriced()
}

class PhotoListPresentation: PhotoListPresentationLogic {
    private weak var view: PhotoListDisplayLogic?
    
    init(view: PhotoListDisplayLogic) {
        self.view = view
    }
    
    func presentFetchedPhotos() {
        // Interactor 에 의해서 호출됩니다.
        DebugLog("presentFetchedPhotos")
        self.view?.displayFetchedPhotos()
    }
    func presentAlertDenied() {
        self.view?.displayOneAlert(title: "", message: "사진 접근 권한이 거절되어 있습니다.")
    }
    func presentAlertRestriced() {
        self.view?.displayOneAlert(title: "", message: "사진 접근 권한이 제한되어 있습니다.")
    }
}
