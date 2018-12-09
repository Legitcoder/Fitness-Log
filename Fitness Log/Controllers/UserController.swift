//
//  UserController.swift
//  Fitness Log
//
//  Created by Moin Uddin on 12/8/18.
//  Copyright © 2018 Moin Uddin. All rights reserved.
//

import Foundation
import CoreData

class UserController {
    
    private func addEntry(user: User, entry: Entry) {
        user.addToEntries(entry)
        CoreDataController.saveToPersistent()
    }
    
}
