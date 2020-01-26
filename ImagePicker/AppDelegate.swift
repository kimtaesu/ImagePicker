//
//  AppDelegate.swift
//  ImagePicker
//
//  Created by tyler on 2020/01/24.
//  Copyright © 2020 tyler. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let interactor = PhotoListInteractor()
        let rootViewController = PhotoListViewController(interactor: interactor)
        
        let window = UIWindow()
        window.rootViewController = UINavigationController(rootViewController: rootViewController)
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
}

