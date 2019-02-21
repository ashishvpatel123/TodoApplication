//
//  ToDoDatabase.swift
//  TodoApplication
//
//  Created by IMCS2 on 2/19/19.
//  Copyright © 2019 IMCS2. All rights reserved.
//

import Foundation
import Firebase

var toDoTaskData : [[String : String]] = []

class ToDoDatabase{
    
    
    var title : String=""
    var discription : String=""
    
    var ref : DatabaseReference!
    
    init(title:String , discription:String) {
        self.title = title
        self.discription = discription

        ref = Database.database().reference().child("User/ToDoTask")
    }
    
    
    func toDisctionary()->[String:String]{
        return[
            "title" : title,
            "discription" : discription
        ]
    }
        
    func saveDatabase(){
        ref.childByAutoId().setValue(toDisctionary())
        toDoTaskData.insert(toDisctionary(), at: 0)
        print("todotask Database : \(toDoTaskData)")
        
    }
    
    static func readDatabase(){
        var ref : DatabaseReference!
        ref =  Database.database().reference().child("User/ToDoTask")
        ref.observeSingleEvent(of: .value) { (snapshot) in
            for child in snapshot.children {
                let snap  = child as! DataSnapshot
                let key = snap.key
                let value = snap.value as! [String:String]
                toDoTaskData.insert(value, at: 0)
                print("key : \(key) value \(value)")
                
            }
        }
    }
    
    
    
}
