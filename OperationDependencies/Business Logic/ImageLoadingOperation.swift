//
//  ImageLoadingOperation.swift
//  OperationDependencies
//
//  Created by Zafar on 21/12/20.
//  Copyright © 2020 Zafar. All rights reserved.
//

import UIKit

public class ImageLoadingOperation: AsynchronousOperation, ImageProvider {
    
    // MARK: - Initialization
    public init(url: URL) {
        self.url = url
        super.init()
    }
    
    // MARK: - Properties
    private let url: URL
    public var image: UIImage?
    
    // MARK: - Execution
    public override func start() {
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }
            
            defer { self.state = .finished }
            
            guard error == nil, let data = data else { return }
            
            let image = UIImage(data: data)
            
            self.image = image
        }.resume()
    }
}
