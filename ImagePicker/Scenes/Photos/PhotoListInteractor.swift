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

final class PhotoListInteractor: VIPInteraction, PhotoListBusinessLogic {
    
    func fetchPhotos() {
        // ViewController 에 의해서 호출됩니다.
    }
}
