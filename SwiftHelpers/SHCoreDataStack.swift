//
//  SHCoreDataStack.swift
//  SwiftHelpers
//
//  Created by David Miotti on 15/08/16.
//  Copyright © 2016 Wopata. All rights reserved.
//

import UIKit
import CoreData

public let kCoreDataStackErrorDomain = "CoreDataStack"

public protocol NamedEntity {
    static var entityName: String { get }
    static func entityFetchRequest() -> NSFetchRequest
}

public extension NamedEntity {
    static func entityFetchRequest() -> NSFetchRequest {
        return NSFetchRequest(entityName: entityName)
    }
    static func insertEntity(inContext context: NSManagedObjectContext) -> Self {
        return NSEntityDescription.insertNewObjectForEntityForName(entityName, inManagedObjectContext: context) as! Self
    }
}

public let kCoreDataStackStoreWillChange = "CoreDataStackStoreWillChange"
public let kCoreDataStackStoreDidChange = "CoreDataStackStoreDidChange"

private var momdFilename: String!
private var SQLLiteFilename: String!

public final class CoreDataStack: NSObject {

    public static let shared = CoreDataStack()

    public class func initializeWithMomd(momd: String, sql: String) {
        momdFilename = momd
        SQLLiteFilename = sql
    }

    override init() {
        super.init()

        registerNotificationObservers()
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    public lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.wopata.Dependn" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()

    public lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        guard let modelURL = NSBundle.mainBundle().URLForResource(momdFilename, withExtension: "momd") else {
            fatalError("Couldn't find model for name : \(SQLLiteFilename) in bundle.")
        }

        guard let mom = NSManagedObjectModel(contentsOfURL: modelURL) else {
            fatalError("Couldn't build a NSManagedObjectModel from file at URL: \(modelURL)")
        }
        return mom
    }()

    public lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent(SQLLiteFilename)
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            var opts = [String: AnyObject]()
            opts[NSMigratePersistentStoresAutomaticallyOption] = true
            opts[NSInferMappingModelAutomaticallyOption] = true
            if !DeviceType.isSimulator {
                opts[NSPersistentStoreUbiquitousContentNameKey] = "Dependn"
            }
            opts[NSPersistentStoreFileProtectionKey] = NSFileProtectionCompleteUntilFirstUserAuthentication
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: opts)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason

            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: kCoreDataStackErrorDomain, code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            fatalError("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
        }

        return coordinator
    }()

    public lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    // MARK: - Core Data Saving support

    public func saveContext() {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    // MARK: - Handle CoreData notifications

    private func registerNotificationObservers() {
        let nc = NSNotificationCenter.defaultCenter()
        nc.addObserver(self, selector: #selector(CoreDataStack.storesWillChange(_:)), name: NSPersistentStoreCoordinatorStoresWillChangeNotification, object: nil)
        nc.addObserver(self, selector: #selector(CoreDataStack.storesDidChange(_:)), name: NSPersistentStoreCoordinatorStoresDidChangeNotification, object: nil)
        nc.addObserver(self, selector: #selector(CoreDataStack.persistentStoreDidImportUbiquitousContentChanges(_:)), name: NSPersistentStoreDidImportUbiquitousContentChangesNotification, object: nil)
    }

    func storesWillChange(notification: NSNotification) {
        managedObjectContext.performBlock {
            if self.managedObjectContext.hasChanges {
                do {
                    try self.managedObjectContext.save()
                } catch let err as NSError {
                    NSLog("Error while saving context from 'storesWillChange:': \(err)")
                }
            }
            self.managedObjectContext.reset()
        }

        NSNotificationCenter.defaultCenter().postNotificationName(kCoreDataStackStoreWillChange, object: nil, userInfo: nil)
    }

    func storesDidChange(notification: NSNotification) {
        NSNotificationCenter.defaultCenter().postNotificationName(kCoreDataStackStoreDidChange, object: nil, userInfo: nil)
    }

    func persistentStoreDidImportUbiquitousContentChanges(notification: NSNotification) {
        managedObjectContext.performBlock {
            self.managedObjectContext.mergeChangesFromContextDidSaveNotification(notification)
            NSLog("NSPersistentStoreDidImportUbiquitousContentChangesNotification executed")
        }
    }
}
