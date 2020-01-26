//
//  ViewController.swift
//  ImagePicker
//
//  Created by tyler on 2020/01/24.
//  Copyright © 2020 tyler. All rights reserved.
//

import UIKit
import Photos

protocol PhotoListDisplayLogic: class
{
  func displayFetchedPhotos()
}

protocol VIPView: class {
    associatedtype T: VIPInteraction
    var interactor: T { get }
}

protocol VIPInteraction {
    
}

class PhotoListViewController: UIViewController, VIPView, PhotoListDisplayLogic {
    
    var interactor: PhotoListInteractor
    
        
    init(interactor: PhotoListInteractor) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func fetchPhotos() {
        self.interactor.fetchPhotos()
    }
    
    func displayFetchedPhotos() {
        // Presenter 에 의해서 호출됩니다.
    }
}

