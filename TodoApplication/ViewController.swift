//
//  ViewController.swift
//  TodoApplication
//
//  Created by IMCS2 on 2/14/19.
//  Copyright © 2019 IMCS2. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController , UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var toDoTableView: UITableView!
    let defaults = UserDefaults.standard
    
     var data: [String] = []
     var ref : DatabaseReference!
    let dispachGroup = DispatchGroup()
    
    
    
    //  right to left swipe to add into completed task
    func tableView(_ tableView: UITableView,
                   leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let closeAction = UIContextualAction(style: .destructive, title:  "Done", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            print("OK, marked as Closed")
            success(true)
            
            self.addToCompletedTaskList(index: indexPath.row)
            self.deleteToDoData(index: indexPath.row)
        })
        closeAction.image = UIImage(named: "tick")
        closeAction.backgroundColor = .blue
        return UISwipeActionsConfiguration(actions: [closeAction])
        
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoTaskData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell")! //1.
        
        
        let toDoDictionary = toDoTaskData[indexPath.row] //2.
        
        let title = toDoDictionary["title"]
       
        let discription = toDoDictionary["discription"]
        
        cell.textLabel?.text =  title//3.
        
        cell.detailTextLabel?.text = discription
        
        return cell //4.
    }
    // left to right swipe and delete the view
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            deleteToDoData(index : indexPath.row)
            //toDoTableView.deleteRows(at: [indexPath], with: .bottom)
            

        }
    }

    // adding to new userdefaults as ccompted task
    func addToCompletedTaskList(index : Int)  {
        var completedToDoList = defaults.stringArray(forKey: "CompletedTasks") ?? [String]()
        
        completedToDoList.insert(data[index], at: 0)
    
        defaults.set(completedToDoList, forKey: "CompletedTasks")
    }
   

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        FirebaseApp.configure()
        ref = Database.database().reference().child("User/ToDoTask")

        toDoTableView.dataSource = self
        getDataFromFirebase()
        
        dispachGroup.notify(queue: .main) {
            self.toDoTableView.reloadData()
        }
        
        updateToDoData()
        print("data")
        
    }
    // updating the view when ever it comes back
    override func viewWillAppear(_ animated: Bool) {
        print("view will appear")
        updateToDoData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("view did appear")
    }

    override func viewWillDisappear(_ animated: Bool) {
        print("view will disappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("view did disappera")
    }
    
  // updating data function
    func updateToDoData(){
    
        //data = defaults.stringArray(forKey: "usertaskList") ?? [String]()
        toDoTableView.reloadData()
        
    }
    
    // deleting the perticular item from userdefaults 
    func deleteToDoData(index : Int){
        //data.remove(at: index)
        //defaults.set(data, forKey: "usertaskList")
        toDoTaskData.remove(at: index)
        updateToDoData()
        print("after delete : \(toDoTaskData)")
        
    }
    // waiting to get data load
    // need to update the code
    func getDataFromFirebase(){
        let time = DispatchTime.now() + .seconds(1)
        ToDoDatabase.readDatabase()
        DispatchQueue.main.asyncAfter(deadline: time) {
            self.toDoTableView.reloadData()
        }
    }
    
}

