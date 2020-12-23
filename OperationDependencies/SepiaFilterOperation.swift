//
//  SepiaFilterOperation.swift
//  OperationDependencies
//
//  Created by Zafar on 21/12/20.
//  Copyright © 2020 Zafar. All rights reserved.
//

import UIKit

public class SepiaFilterOperation: Operation {
    
    public init(completionHandler: @escaping (UIImage?) -> Void) {
        
        self.completionHandler = completionHandler
        
        super.init()
    }
    
    public let completionHandler: ((UIImage?) -> Void)
    
    public override func main() {
        guard let initialImage = dependencies
            .compactMap ({ ($0 as? ImageLoadingOperation)?.image })
            .first else { return }
        
        guard let initialCIImage = CIImage(image: initialImage) else {
            return
        }
        
        
        guard let sepiaCIImage = sepiaFilterCIImage(initialCIImage, intensity: 0.9) else { return }
        
        let finalFilteredImage = UIImage(ciImage: sepiaCIImage)
        
        DispatchQueue.main.async {
            self.completionHandler(finalFilteredImage)
        }
    }
    
    func sepiaFilterCIImage(_ input: CIImage, intensity: Double) -> CIImage? {
        let sepiaFilter = CIFilter(name: "CISepiaTone")
        sepiaFilter?.setValue(input, forKey: kCIInputImageKey)
        sepiaFilter?.setValue(intensity, forKey: kCIInputIntensityKey)
        return sepiaFilter?.outputImage
    }
    
}
