//
//  SHManagedObjectContext+CascadeSave.swift
//  SwiftHelpers
//
//  Created by David Miotti on 22/11/15.
//  Copyright © 2015 Wopata. All rights reserved.
//

import UIKit
import CoreData

public extension NSManagedObjectContext {
    
    public func cascadeSave() throws {
        var contextToSave: NSManagedObjectContext? = self
        while let ctx = contextToSave {
            if ctx.hasChanges {
                try ctx.save()
            }
            contextToSave = contextToSave?.parentContext
        }
    }
    
}
