//
//  NamedEntity.swift
//  SwiftHelpers
//
//  Created by David Miotti on 27/03/2017.
//  Copyright © 2017 Muxu.Muxu. All rights reserved.
//

import Foundation
import CoreData

public protocol NamedEntity {
    static var entityName: String { get }
}

public extension NamedEntity where Self: NSManagedObject {
    static func insertEntity(inContext context: NSManagedObjectContext) -> Self {
        return NSEntityDescription.insertNewObject(forEntityName: entityName, into: context) as! Self
    }
    
    static func entityFetchRequest() -> NSFetchRequest<Self> {
        return NSFetchRequest<Self>(entityName: entityName)
    }
}
