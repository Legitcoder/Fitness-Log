//
//  CoreDataController.swift
//  Fitness Log
//
//  Created by Moin Uddin on 12/9/18.
//  Copyright © 2018 Moin Uddin. All rights reserved.
//

import Foundation
import CoreData


class CoreDataController {
    
    static func saveToPersistent(context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        do {
            try CoreDataStack.shared.save(context: context)
        } catch {
            NSLog("Error Saving to Core Data: \(error)")
        }
    }
    
}
