//
//  AddTaskViewController.swift
//  TodoApplication
//
//  Created by IMCS2 on 2/14/19.
//  Copyright © 2019 IMCS2. All rights reserved.
//

import UIKit


class AddTaskViewController: UIViewController {
    
    var previousSavedToDoList: [String] = []


    @IBOutlet weak var taskDecEF: UITextField!
    @IBOutlet weak var taskTitleEF: UITextField!
    @IBOutlet weak var saveTaskButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //make button curve edges
        saveTaskButton.layer.cornerRadius = 10
        saveTaskButton.clipsToBounds = true
        
        
        
        
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        print("save button clicked")
        
        let taskTitle = taskTitleEF.text
        let taskDec = taskDecEF.text
        
        
        //check weather filed is empty or not
        if taskDec != nil && taskTitle != nil{
            
           // let taskDetail = TaskModel(taskTitle: taskTitle! ,taskDescription: taskDec! )
            
            // setting it agin empty
            taskTitleEF.text = ""
            taskDecEF.text = ""
            
            
            
            let defaults = UserDefaults.standard
            
            var previousSavedToDoList = defaults.stringArray(forKey: "usertaskList") ?? [String]()
            
            previousSavedToDoList.insert(taskDec! , at: 0)
            
            defaults.set(previousSavedToDoList, forKey: "usertaskList")
            
            
            
            // print(toDoList)
        }
        
    }
    
   

}
