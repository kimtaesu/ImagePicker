//
//  MockPhotoListPresentationLogic+Stub.swift
//  ImagePickerTests
//
//  Created by tyler on 2020/01/26.
//  Copyright © 2020 tyler. All rights reserved.
//

import Foundation
import Cuckoo

extension MockPhotoListPresentationLogic {
    func stubSample() {
        stubPresentFetchedPhotos()
        stub(self) { mock in
            when(mock.presentAlertDenied()).then { }
            when(mock.presentAlertRestriced()).then { }
        }
    }
    func stubPresentFetchedPhotos() {
        stub(self) { mock in
            when(mock.presentFetchedPhotos()).then { }
        }
    }
}
