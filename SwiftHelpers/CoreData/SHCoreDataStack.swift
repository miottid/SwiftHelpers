//
//  SHCoreDataStack.swift
//  SwiftHelpers
//
//  Created by David Miotti on 15/08/16.
//  Copyright © 2016 Muxu.Muxu. All rights reserved.
//

import UIKit
import CoreData

public let kCoreDataStackErrorDomain = "CoreDataStack"
public let kCoreDataStackStoreWillChange = "CoreDataStackStoreWillChange"
public let kCoreDataStackStoreDidChange = "CoreDataStackStoreDidChange"

private var momdFilename: String!
private var SQLLiteFilename: String!
private var persistantStoreOptions: [AnyHashable : Any]!

public final class CoreDataStack: NSObject {

    public static let shared = CoreDataStack()

    public class func initializeWithMomd(_ momd: String, sql: String, persistantStoreOptions opts: [AnyHashable : Any]? = nil) {
        momdFilename = momd
        SQLLiteFilename = sql
        persistantStoreOptions = opts ?? [
            NSMigratePersistentStoresAutomaticallyOption: true,
            NSInferMappingModelAutomaticallyOption: true,
            NSPersistentStoreFileProtectionKey: FileProtectionType.completeUntilFirstUserAuthentication
        ]
    }

    override init() {
        super.init()

        registerNotificationObservers()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    public lazy var applicationDocumentsDirectory: URL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.Muxu.Muxu.xxx" in the application's documents Application Support directory.
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1]
    }()

    public lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        guard let modelURL = Bundle.main.url(forResource: momdFilename, withExtension: "momd") else {
            fatalError("Couldn't find model for name : \(String(describing: momdFilename)) in bundle.")
        }

        guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Couldn't build a NSManagedObjectModel from file at URL: \(modelURL)")
        }
        return mom
    }()

    public lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent(SQLLiteFilename)
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: persistantStoreOptions)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?

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
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    // MARK: - Core Data Saving support

    func saveContext() {
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
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(CoreDataStack.storesWillChange(_:)), name: NSNotification.Name.NSPersistentStoreCoordinatorStoresWillChange, object: nil)
        nc.addObserver(self, selector: #selector(CoreDataStack.storesDidChange(_:)), name: NSNotification.Name.NSPersistentStoreCoordinatorStoresDidChange, object: nil)
    }

    @objc func storesWillChange(_ notification: Foundation.Notification) {
        managedObjectContext.perform {
            if self.managedObjectContext.hasChanges {
                do {
                    try self.managedObjectContext.save()
                } catch let err as NSError {
                    NSLog("Error while saving context from 'storesWillChange:': \(err)")
                }
            }
            self.managedObjectContext.reset()
        }

        NotificationCenter.default.post(name: Notification.Name(rawValue: kCoreDataStackStoreWillChange), object: nil, userInfo: nil)
    }

    @objc func storesDidChange(_ notification: Foundation.Notification) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: kCoreDataStackStoreDidChange), object: nil, userInfo: nil)
    }
}
