//
//  AddTaskViewController.swift
//  Todo List
//
//  Created by Kinshuk  Bairagi on 06/08/16.
//  Copyright © 2016 Kinshuk Bairagi. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController, UINavigationControllerDelegate {
    
    var newTask : Task?

    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var titleText: UITextField!
    
    @IBOutlet weak var descText: UITextView!
    
    // MARK: Navigation
    @IBAction func cancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    // This method lets you configure a view controller before it's presented.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            
            newTask = Task(title: titleText.text! ,  desc: descText.text)
         }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.descText.contentInset = UIEdgeInsetsMake(0, 10, 0, 5); // top, left, bottom, right

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  

}
