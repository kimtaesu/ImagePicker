//
//  PhotoCell.swift
//  ImagePicker
//
//  Created by tyler on 2020/01/26.
//  Copyright © 2020 tyler. All rights reserved.
//

import UIKit

final class ThumbnailCell: UICollectionViewCell, CellReusableIdentifier {
    
    private let thumbnail: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private let durationTime: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        [thumbnail, durationTime].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.contentView.addSubview($0)
        }
        
        thumbnail.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        thumbnail.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        thumbnail.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        thumbnail.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        
        durationTime.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 10).isActive = true
        durationTime.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 10).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var item: ThumbnailViewModel
    
    public func configCell(_ item: ThumbnailViewModel) {
        self.item = item
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    public func setImage(_ image: UIImage?) {
        self.thumbnail.image = image
    }
    
    public func getImageRequestId() -> IMAGE_REQUEST_ID {
        return self.item.id
    }
}

