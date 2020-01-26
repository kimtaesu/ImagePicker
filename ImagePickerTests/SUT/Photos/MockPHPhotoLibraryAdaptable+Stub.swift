//
//  MockPHPhotoLibraryAdaptable+Stub.swift
//  ImagePickerTests
//
//  Created by tyler on 2020/01/26.
//  Copyright © 2020 tyler. All rights reserved.
//

import Photos
import Cuckoo

extension MockPHPhotoLibraryAdaptable {
    func stubAuthorizationStatus(_ expect: PHAuthorizationStatus) {
        stub(self) { mock in
            when(mock.authorizationStatus()).then { expect }
        }
    }
}
