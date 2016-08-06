//
//  Tasks.swift
//  Todo List
//
//  Created by Kinshuk  Bairagi on 06/08/16.
//  Copyright © 2016 Kinshuk Bairagi. All rights reserved.
//

import UIKit
import CoreData


class Task: NSObject, NSCoding {
    
    var title: String
    var desc: String
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("tasks")
    
    
    struct PropertyKey {
        static let titleKey = "title"
        static let descKey = "desc"
    }
    
    init(title:String, desc:String){
        self.title = title
        self.desc = desc
        super.init()
    }
   
    // MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(title, forKey: PropertyKey.titleKey)
        aCoder.encodeObject(desc, forKey: PropertyKey.descKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let t = aDecoder.decodeObjectForKey(PropertyKey.titleKey) as! String
        let d = aDecoder.decodeObjectForKey(PropertyKey.descKey) as! String
        self.init(title: t,desc: d)
    }
}


class TaskManager: NSObject{
    var tasks = [Task]()
    
    
    func save(_task: Task) {
        tasks.append(_task)
        sync()
    }
    
    func sync(){
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(tasks, toFile: Task.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save meals...")
        }
    }
    
    func remove(position:Int){
        tasks.removeAtIndex(position)
        sync()
    }
    
    func getAll() -> [Task]?{
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Task.ArchiveURL.path!) as? [Task]
    }
    
    func restore(){
        if let values =  getAll() {
            tasks = values
        }
    }
    
}

var taskMgr: TaskManager = TaskManager()
 