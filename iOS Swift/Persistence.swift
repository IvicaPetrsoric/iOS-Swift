//
//  Persistence.swift
//  iOS Swift
//
//  Created by Ivica Petrsoric on 17/05/2021.
//  Copyright © 2021 ivica petrsoric. All rights reserved.
//

import CoreData

struct PersistenceController {
    
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "TodoList")
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error: \(error)")
            }
            
            print("Setup CoreData")
        }
    }
    
    
}
