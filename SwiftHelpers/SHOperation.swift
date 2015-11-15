//
//  SHOperation.swift
//  SwiftHelpers
//
//  Created by David Miotti on 15/11/15.
//  Copyright © 2015 Wopata. All rights reserved.
//

import Foundation

public class SHOperation: NSOperation {
    
    override public var asynchronous: Bool {
        return true
    }
    
    private var _executing = false {
        willSet {
            willChangeValueForKey("isExecuting")
        }
        didSet {
            didChangeValueForKey("isExecuting")
        }
    }
    
    override public var executing: Bool {
        return _executing
    }
    
    private var _finished = false {
        willSet {
            willChangeValueForKey("isFinished")
        }
        
        didSet {
            didChangeValueForKey("isFinished")
        }
    }
    
    override public var finished: Bool {
        return _finished
    }
    
    override public func start() {
        _executing = true
        execute()
    }
    
    func execute() {
        fatalError("You must override this")
    }
    
    func finish() {
        _executing = false
        _finished = true
    }
}