//
//  SepiaFilterOperation.swift
//  OperationDependencies
//
//  Created by Zafar on 21/12/20.
//  Copyright © 2020 Zafar. All rights reserved.
//

import UIKit

public protocol ImageProvider: class {
    var image: UIImage? { get }
}

public class SepiaFilterOperation: Operation {
    
    public init(completionHandler: @escaping (UIImage?) -> Void,
                inputImage: UIImage? = nil) {
        
        self.completionHandler = completionHandler
        self.inputImage = inputImage
        
        super.init()
    }
    
    /// A property for cases the SepiaFilterOperation doesn't have a dependency and we want to use it directly
    public var inputImage: UIImage?
    
    public let completionHandler: ((UIImage?) -> Void)
    
    public override func main() {
        // Search for a dependency that provides a UIImage
        let dependencyImage = dependencies
            .compactMap ({ ($0 as? ImageProvider)?.image })
            .first
        
        // Obtain a UIImage either directly or from a dependency
        guard let inputImage = self.inputImage ?? dependencyImage else { return }
        
        guard let initialCIImage = CIImage(image: inputImage) else {
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
