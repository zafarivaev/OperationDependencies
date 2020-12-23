//
//  PhotosCollectionViewDataSource.swift
//  OperationDependencies
//
//  Created by Zafar on 18/11/20.
//  Copyright © 2020 Zafar. All rights reserved.
//

import UIKit

public class PhotosCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    // MARK: - Properties
    private let operationQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.qualityOfService = .utility
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
    
    // MARK: - Data Source Methods
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 40
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PhotoCollectionViewCell.self), for: indexPath) as! PhotoCollectionViewCell
        cell.imageView.image = nil
        
        let url = URL(string: "https://picsum.photos/200")!
        
        let imageLoadingOperation = ImageLoadingOperation(url: url)
        
        let sepiaFilterOperation = SepiaFilterOperation() { (image) in
            guard let cell = collectionView.cellForItem(at: indexPath) as? PhotoCollectionViewCell else { return }
            
            cell.imageView.image = image
        }
        
        sepiaFilterOperation.addDependency(imageLoadingOperation)
        
        operationQueue.addOperation(imageLoadingOperation)
        operationQueue.addOperation(sepiaFilterOperation)
        
        return cell
    }
    
}
