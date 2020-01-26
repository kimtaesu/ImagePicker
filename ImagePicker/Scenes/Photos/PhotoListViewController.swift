//
//  ViewController.swift
//  ImagePicker
//
//  Created by tyler on 2020/01/24.
//  Copyright © 2020 tyler. All rights reserved.
//

import UIKit
import Photos

protocol PhotoListDisplayLogic: class {
    func displayFetchedPhotos()
    func displayOneAlert(title: String, message: String)
}

class PhotoListViewController: BaseViewController, PhotoListDisplayLogic {
    private var interactor: PhotoListBusinessLogic?

    init() {
        super.init(nibName: nil, bundle: nil)
        let presenter = PhotoListPresentation(view: self)
        self.interactor = PhotoListInteractor(presenter: presenter, photoAdapter: PHPhotoLibraryAdapter())
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchPhotos()
    }

    func fetchPhotos() {
        self.interactor?.fetchPhotos()
    }

    func displayFetchedPhotos() {
        // Presenter 에 의해서 호출됩니다.
        DebugLog("displayFetchedPhotos")
    }
    
    func displayOneAlert(title: String, message: String) {
        UIAlertController.make(title: title, message: message).alertShow(self)
    }
}

