//
//  CompletedTaskVC.swift
//  TodoApplication
//
//  Created by IMCS2 on 2/15/19.
//  Copyright © 2019 IMCS2. All rights reserved.
//

import UIKit

class CompletedTaskVC: UIViewController,UITableViewDataSource {
    @IBOutlet weak var completedTaskTable: UITableView!
    
    var completedTask : [String] = []
    let defaults = UserDefaults.standard
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            deleteCompletedTask(index : indexPath.row)
            completedTaskTable.deleteRows(at: [indexPath], with: .bottom)
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return completedTask.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompletedTaskCell")! //1.
        
        
        let text = completedTask[indexPath.row] //2.
        
        cell.textLabel?.text = text //3.
        
        return cell //4.
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCompletedTask()
        

        // Do any additional setup after loading the view.
        completedTaskTable.dataSource = self
    }
    
    func getCompletedTask() {
        completedTask = defaults.stringArray(forKey: "CompletedTasks") ?? [String]()
        completedTaskTable.reloadData()

    }
    
        func deleteCompletedTask(index :Int){
            completedTask.remove(at: index)
            defaults.set(completedTask, forKey: "CompletedTasks")
    }

}
