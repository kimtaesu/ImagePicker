//
//  PhotoListInteractor.swift
//  ImagePickerTests
//
//  Created by tyler on 2020/01/26.
//  Copyright © 2020 tyler. All rights reserved.
//

import Foundation
import XCTest
import Cuckoo
import Photos
@testable import ImagePicker

class PhotoListInteractorTests: XCTestCase {
    
    var subject: PhotoListInteractor!
    var presenter: MockPhotoListPresentationLogic!
    var adapter: MockPHPhotoLibraryAdaptable!
    
    override func setUp() {
        presenter = MockPhotoListPresentationLogic()
        adapter = MockPHPhotoLibraryAdaptable()
        subject = PhotoListInteractor(presenter: presenter, photoAdapter: adapter)
    }
    func test_사진접근권한상태가_Denied라면_권한이없음이표시되어야함() {
        assertPresenterAlert(.denied, {
            verify(presenter, times(1)).presentAlertDenied()
            verifyNoMoreInteractions(presenter)
        })
    }
    func test_사진접근권한상태가_Restricted라면_권한이없음이표시되어야함() {
        assertPresenterAlert(.restricted, {
            verify(presenter, times(1)).presentAlertRestriced()
            verifyNoMoreInteractions(presenter)
        })
    }
    
    private func assertPresenterAlert(_ status: PHAuthorizationStatus, _ assertClosure: () -> Void) {
        // Given
        adapter.stubAuthorizationStatus(status)
        presenter.stubSample()
        
        // When
        subject.fetchPhotos()
        
        // Then
        assertClosure()
    }
}

