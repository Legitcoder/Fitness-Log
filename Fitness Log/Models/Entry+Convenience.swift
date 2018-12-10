//
//  Entry+Convenience.swift
//  Fitness Log
//
//  Created by Moin Uddin on 12/9/18.
//  Copyright © 2018 Moin Uddin. All rights reserved.
//

import Foundation
import CoreData

extension Entry {
    convenience init(date: Date, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.date = date
    }
    
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, Y"
        let date = dateFormatter.string(from: (self.date)!)
        return date
    }
}
