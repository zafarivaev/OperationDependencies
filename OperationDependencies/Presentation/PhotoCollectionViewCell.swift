//
//  PhotoCollectionViewCell.swift
//  OperationDependencies
//
//  Created by Zafar on 10/21/20.
//  Copyright © 2020 Zafar. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - UI Elements
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - UI Setup
    private func setupUI() {
        self.contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor
                .constraint(equalTo: self.contentView.widthAnchor),
            imageView.heightAnchor
                .constraint(equalTo: self.contentView.heightAnchor),
            imageView.centerXAnchor
                .constraint(equalTo: self.contentView.centerXAnchor),
            imageView.centerYAnchor
                .constraint(equalTo: self.contentView.centerYAnchor),
        ])
    }
    
}
