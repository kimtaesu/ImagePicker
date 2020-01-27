//
//  UICollectionView+Register.swift
//  ImagePicker
//
//  Created by tyler on 2020/01/26.
//  Copyright © 2020 tyler. All rights reserved.
//

import UIKit

public extension UICollectionView {
    func register<C: UICollectionViewCell & CellReusableIdentifier>(_ cellClass: C.Type) {
        self.register(cellClass, forCellWithReuseIdentifier: cellClass.swiftIdentifier)
    }

    func dequeueCell<C: UICollectionViewCell & CellReusableIdentifier>(for cellClass: C.Type, indexPath: IndexPath) -> C {
        // swiftlint:disable force_cast
        return self.dequeueReusableCell(withReuseIdentifier: cellClass.swiftIdentifier, for: indexPath) as! C
    }
}
