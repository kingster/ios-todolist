//
//  Task.swift
//  Todo List
//
//  Created by Kinshuk  Bairagi on 20/08/16.
//  Copyright © 2016 Kinshuk Bairagi. All rights reserved.
//

import Foundation
import CoreData
import UIKit

extension Task {
    @NSManaged var desc: String?
    @NSManaged var title: String?
}

class FakeTask{
    var desc: String?
    var title: String
    
    required init(title:String, desc:String?){
        self.title = title
        self.desc = desc
    }
}

class Task: NSManagedObject {
    static let entityName = "Task"
    // Insert code here to add functionality to your managed object subclass
    
    
}

class TaskService {
    
    var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext){
        self.context = context
    }
    
    
    //let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext

    // Saves all changes
    func saveChanges(){
        do{
            try context.save()
        } catch let error as NSError {
            // failure
            print(error)
        }
    }
    
    // Creates a new Person
    func create(title: String, desc: String?) -> Task {
        
        let newItem = NSEntityDescription.insertNewObjectForEntityForName(Task.entityName, inManagedObjectContext: context) as! Task
        
        newItem.title = title
        newItem.desc = desc
        
        return newItem
    }
    
    // Gets all with an specified predicate.
    // Predicates examples:
    // - NSPredicate(format: "name == %@", "Juan Carlos")
    // - NSPredicate(format: "name contains %@", "Juan")
    func get(withPredicate queryPredicate: NSPredicate) -> [Task]{
        let fetchRequest = NSFetchRequest(entityName: Task.entityName)
        
        fetchRequest.predicate = queryPredicate
        
        do {
            let response = try context.executeFetchRequest(fetchRequest)
            return response as! [Task]
            
        } catch let error as NSError {
            // failure
            print(error)
            return [Task]()
        }
    }
    
    
    // Deletes a person
    func delete(id: NSManagedObjectID){
        if let personToDelete = getById(id){
            context.deleteObject(personToDelete)
        }
    }
    
    // Gets all.
    func getAll() -> [Task]{
        return get(withPredicate: NSPredicate(value:true))
    }

    // Gets a person by id
    func getById(id: NSManagedObjectID) -> Task? {
        return context.objectWithID(id) as? Task
    }
}