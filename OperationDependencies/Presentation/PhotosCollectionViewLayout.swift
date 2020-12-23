//
//  PhotosCollectionViewLayout.swift
//  OperationDependencies
//
//  Created by Zafar on 10/31/20.
//  Copyright © 2020 Zafar. All rights reserved.
//

import UIKit

public class PhotosCollectionViewLayout: UICollectionViewFlowLayout {
    
    public override init() {
        super.init()
        
        let screenWidth = UIScreen.main.bounds.width
        
        self.itemSize = CGSize(width: screenWidth * 0.45,
                               height: screenWidth * 0.45)
        
        let cellsInEachRow = (screenWidth / self.itemSize.width).rounded()
        
        let totalLeftSpace = screenWidth - (cellsInEachRow * self.itemSize.width)
        let interItemSpace = totalLeftSpace / (cellsInEachRow + 1)
        
        self.minimumInteritemSpacing = interItemSpace

        self.sectionInset = UIEdgeInsets(top: 0,
                                         left: interItemSpace,
                                         bottom: 0,
                                         right: interItemSpace)
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
