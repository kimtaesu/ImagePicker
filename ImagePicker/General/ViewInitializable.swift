//
//  ViewInitializable.swift
//  ImagePicker
//
//  Created by tyler on 2020/01/26.
//  Copyright © 2020 tyler. All rights reserved.
//

import Foundation

public protocol ViewInitializable {
    func addViews()
    func setConstraints()
}

extension ViewInitializable {
    func setConstraints() { }
}

import UIKit


public extension ViewInitializable where Self: UIView {
    func initViews() {
        self.addViews()
        self.setConstraints()
    }
}

public extension ViewInitializable where Self: UIViewController {
    func initViews() {
        self.addViews()
        self.setConstraints()
    }
}
