//
//  PhotosViewController.swift
//  OperationDependencies
//
//  Created by Zafar on 10/21/20.
//  Copyright © 2020 Zafar. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    // MARK: - Properties
    private let dataSource = PhotosCollectionViewDataSource()

    // MARK: - UI Elements
    private lazy var collectionView: UICollectionView = {
        let layout = PhotosCollectionViewLayout()
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.backgroundColor = .white
        collectionView.isPrefetchingEnabled = false
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: PhotoCollectionViewCell.self))
        collectionView.dataSource = dataSource
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    // MARK: - UI Setup
    private func setupUI() {
        if #available(iOS 13.0, *) {
            self.overrideUserInterfaceStyle = .light
        }
        
        self.view.backgroundColor = .white
        
        self.view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.widthAnchor
                .constraint(equalTo: self.view.widthAnchor),
            collectionView.heightAnchor
                .constraint(equalTo: self.view.heightAnchor),
            collectionView.centerXAnchor
                .constraint(equalTo: self.view.centerXAnchor),
            collectionView.centerYAnchor
                .constraint(equalTo: self.view.centerYAnchor),
        ])
    }

}

