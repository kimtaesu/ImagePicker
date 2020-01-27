//
//  UICollectionView+Section.swift
//  ImagePicker
//
//  Created by tyler on 2020/01/26.
//  Copyright © 2020 tyler. All rights reserved.
//

import UIKit

extension UICollectionView {

    func sectionWidth(at section: Int) -> CGFloat {
        var width = self.safeAreaLayoutGuide.layoutFrame.width
        width -= self.contentInset.left
        width -= self.contentInset.right

        if let delegate = self.delegate as? UICollectionViewDelegateFlowLayout,
            let inset = delegate.collectionView?(self, layout: self.collectionViewLayout, insetForSectionAt: section) {
            width -= inset.left
            width -= inset.right
        } else if let layout = self.collectionViewLayout as? UICollectionViewFlowLayout {
            width -= layout.sectionInset.left
            width -= layout.sectionInset.right
        }

        return width
    }

}
