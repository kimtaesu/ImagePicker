//
//  AppDelegate.swift
//  ImagePicker
//
//  Created by tyler on 2020/01/24.
//  Copyright © 2020 tyler. All rights reserved.
//

import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let rootViewController = PhotoListViewController()
        let window = UIWindow()
        window.rootViewController = UINavigationController(rootViewController: rootViewController)
        window.makeKeyAndVisible()
        window.backgroundColor = .white
        self.window = window
        return true
    }
}

