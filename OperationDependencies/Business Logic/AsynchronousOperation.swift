//
//  AsynchronousOperation.swift
//  OperationDependencies
//
//  Created by Zafar on 21/12/20.
//  Copyright © 2020 Zafar. All rights reserved.
//

import Foundation

/// Base class for all asynchronous operations
open class AsynchronousOperation: Operation {
    
    enum State: String {
        case ready, executing, finished
        
        fileprivate var keyPath: String {
            return "is\(rawValue.capitalized)"
        }
    }
    
    // Custom property for monitoring state
    var state = State.ready {
        willSet {
            willChangeValue(forKey: newValue.keyPath)
            willChangeValue(forKey: state.keyPath)
        }
        didSet {
            didChangeValue(forKey: oldValue.keyPath)
            didChangeValue(forKey: state.keyPath)
        }
    }
    
    override open var isExecuting: Bool {
        return state == .executing
    }
    
    override open var isFinished: Bool {
        return state == .finished
    }
    
    // Override for cases when we want to start AsynchronousOperations without adding them to an OperationQueue
    override open var isAsynchronous: Bool {
        return true
    }
    
    // Override start
    override open func start() {
        main()
        state = .executing
    }
}
