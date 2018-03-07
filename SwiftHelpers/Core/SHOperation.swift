//
//  SHOperation.swift
//  SwiftHelpers
//
//  Created by David Miotti on 15/11/15.
//  Copyright © 2015 Muxu.Muxu. All rights reserved.
//

import Foundation

open class SHOperation: Operation {
    
    fileprivate var internalCompletionBlock: ((SHOperation) -> Void)?
    
    public convenience init(completionBlock: ((SHOperation) -> Void)?) {
        self.init()
        internalCompletionBlock = completionBlock
        self.completionBlock = {
            if let block = self.internalCompletionBlock {
                block(self)
            }
        }
    }
    
    override open var isAsynchronous: Bool {
        return true
    }
    
    fileprivate var _executing = false {
        willSet {
            willChangeValue(forKey: "isExecuting")
        }
        didSet {
            didChangeValue(forKey: "isExecuting")
        }
    }
    
    override open var isExecuting: Bool {
        return _executing
    }
    
    fileprivate var _finished = false {
        willSet {
            willChangeValue(forKey: "isFinished")
        }
        
        didSet {
            didChangeValue(forKey: "isFinished")
        }
    }
    
    override open var isFinished: Bool {
        return _finished
    }
    
    override open func start() {
        _executing = true
        execute()
    }
    
    open func execute() {
        fatalError("You must override this")
    }
    
    open func finish() {
        _executing = false
        _finished = true
    }
}
