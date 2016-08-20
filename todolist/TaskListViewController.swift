//
//  TaskListViewController.swift
//  Todo List
//
//  Created by Kinshuk  Bairagi on 06/08/16.
//  Copyright © 2016 Kinshuk Bairagi. All rights reserved.
//

import UIKit
import Alamofire

class TaskListViewController: UITableViewController, TaskUpdateDelegate {

    @IBOutlet var taskTable: UITableView!
    
    @IBAction func didTabButton(sender: AnyObject) {
        
        Alamofire.request(.GET, "https://httpbin.org/get", parameters: ["foo": "bar"])
            .responseJSON { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                }
        }
//        let sec = self.storyboard?.instantiateViewControllerWithIdentifier("AddTaskViewController")
//        self.navigationController?.presentViewController(sec!, animated: true, completion: {})
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load any saved data
        taskTable.reloadData()
        taskMgr.handler = self
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return taskMgr.getTasks().count
    }

   
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        // Configure the cell...
        
        cell.textLabel?.text =  taskMgr.getTasks()[indexPath.row].title
        cell.detailTextLabel?.text = taskMgr.getTasks()[indexPath.row].desc


        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

 
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            taskMgr.remove(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            //Not supported
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
   

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    //MARK : TaskDelegate
    
    func onAdd() {
//        tableView.beginUpdates()
//        let newIndexPath = NSIndexPath(forRow: taskMgr.getTasks().count - 1, inSection: 0)
//        tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
//        tableView.endUpdates()
        taskTable.reloadData()
    }
    
    func onRemove(position:Int) {
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func unwindToTasksList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? AddTaskViewController, task = sourceViewController.newTask {
            print(task)
            taskMgr.save(task)
            
            
        }

    }

}
