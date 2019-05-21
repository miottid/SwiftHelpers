//
//  SHManagedObjectContext+CascadeSave.swift
//  SwiftHelpers
//
//  Created by Guillaume Bellue on 18/01/2017.
//  Copyright © 2017 Muxu.Muxu. All rights reserved.
//

import CoreData

public extension NSManagedObjectContext {

    func cascadeSave() throws {
        var contextToSave: NSManagedObjectContext? = self
        while let ctx = contextToSave {
            if ctx.hasChanges {
                try ctx.save()
            }
            contextToSave = contextToSave?.parent
        }
    }

}
