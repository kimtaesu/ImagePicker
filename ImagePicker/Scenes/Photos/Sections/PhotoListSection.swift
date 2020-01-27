//
//  PhotoListSection.swift
//  ImagePicker
//
//  Created by tyler on 2020/01/26.
//  Copyright © 2020 tyler. All rights reserved.
//

import Foundation

enum PhotoListSection {
    case thumbnail([PhotoListSectionItem])
}

extension PhotoListSection {

    var items: [PhotoListSectionItem] {
        switch self {
        case .thumbnail(let items): return items
        }
    }

    init(original: PhotoListSection, items: [PhotoListSectionItem]) {
        switch original {
        case .thumbnail: self = .thumbnail(items)
        }
    }
}

enum PhotoListSectionItem {
    case thumbnail(ThumbnailViewModel)
}
