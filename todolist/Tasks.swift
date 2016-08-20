//
//  Tasks.swift
//  Todo List
//
//  Created by Kinshuk  Bairagi on 06/08/16.
//  Copyright © 2016 Kinshuk Bairagi. All rights reserved.
//

import UIKit
import CoreData

protocol TaskUpdateDelegate{
    func onAdd()
    func onRemove(position:Int)
}

class TaskManager {

    var handler: TaskUpdateDelegate?
    
    func getTasks() -> [Task]{
        return taskservice.getAll()
    }
    
    
    var taskservice:TaskService
    
    required init() {
        // Create an instance of the service.
        let ctx = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        taskservice = TaskService(context: ctx)
 
    }
    
    func save(_task:FakeTask) {
        taskservice.create(_task.title, desc:_task.desc)
        taskservice.saveChanges()
        handler?.onAdd()
    }
    
    
    func remove(position:Int){
        taskservice.delete(taskservice.getAll()[position].objectID)
        handler?.onRemove(position)
    }
    
 
    
}

var taskMgr: TaskManager = TaskManager()
 