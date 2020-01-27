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
    func displayFetchedPhotos(_ result: PHFetchResult<PHAssetCollection>)
    func displayOneAlert(title: String, message: String)
}

class PhotoListViewController: BaseViewController, PhotoListDisplayLogic, ViewInitializable {


    private var interactor: PhotoListBusinessLogic?

    private let dataSource: PhotoListDataSource
    private let photoAdapter: PHPhotoLibraryAdaptable
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        flowLayout.minimumLineSpacing = 6
        flowLayout.minimumInteritemSpacing = 6
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)

        cv.alwaysBounceVertical = true
        cv.keyboardDismissMode = .interactive
        cv.backgroundColor = .white
        cv.register(ThumbnailCell.self)
        return cv
    }()


    init() {
        defer { self.initViews() }
        self.photoAdapter = PHPhotoLibraryAdapter()
        self.dataSource = PhotoListDataSource(adapter: self.photoAdapter)
        super.init(nibName: nil, bundle: nil)
        let presenter = PhotoListPresentation(view: self)
        self.interactor = PhotoListInteractor(presenter: presenter, photoAdapter: self.photoAdapter)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addViews() {
        [collectionView].forEach {
            self.view.addSubview($0)
        }
        collectionView.delegate = self
        collectionView.dataSource = self.dataSource
    }

    func setConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchPhotos()
    }

    func displayFetchedPhotos(_ result: PHFetchResult<PHAssetCollection>) {
        self.dataSource.setSectionModel(result)
        self.collectionView.reloadData()
    }
    func fetchPhotos() {
        self.interactor?.fetchPhotos(options: .recentAdded)
    }

    func displayFetchedPhotos() {
        // Presenter 에 의해서 호출됩니다.
        DebugLog("displayFetchedPhotos")
    }

    func displayOneAlert(title: String, message: String) {
        UIAlertController.make(title: title, message: message).alertShow(self)
    }
}


extension PhotoListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueCell(for: ThumbnailCell.self, indexPath: indexPath)
        self.dataSource.cancelImage(cell.getImageRequestId())
    }
}
