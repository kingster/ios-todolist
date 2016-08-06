//
//  Tasks.swift
//  Todo List
//
//  Created by Kinshuk  Bairagi on 06/08/16.
//  Copyright © 2016 Kinshuk Bairagi. All rights reserved.
//

import Foundation

struct task {
    var title = "Title"
    var desc:String? = "Description"
}

class TaskManager: NSObject{
    var tasks = [task]()
    
    func addTask(title: String, desc: String?){
        tasks.append(task(title: title, desc: desc))
    }
    
    init(tasks: [task]){
        self.tasks = tasks
    }
}

var taskMgr: TaskManager = TaskManager(tasks: [task(title: "I", desc:nil ), task(title: "2", desc:nil )])
 