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


    @IBOutlet weak var taskDiscriptionFiled: UITextField!
    @IBOutlet weak var taskTitleField: UITextField!
    @IBOutlet weak var saveTaskButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        //make button curve edges
        saveTaskButton.layer.cornerRadius = 10
        saveTaskButton.clipsToBounds = true
   }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        print("save button clicked")
        
        let taskTitle = taskTitleField.text
        let taskDec = taskDiscriptionFiled.text
        
        
        //check weather filed is empty or not
        if taskDec != nil && taskTitle != nil{
            
            // setting it agin empty
            taskTitleField.text = ""
            taskDiscriptionFiled.text = ""
        
            let defaults = UserDefaults.standard
            var previousSavedToDoList = defaults.stringArray(forKey: "usertaskList") ?? [String]()
            previousSavedToDoList.insert(taskDec! , at: 0)
            defaults.set(previousSavedToDoList, forKey: "usertaskList")
            let taskData = ToDoDatabase.init(title: taskTitle!, discription: taskDec!)
            taskData.saveDatabase()
        
        }
        
    }
    
   

}
