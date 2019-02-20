//
//  ToDoDatabase.swift
//  TodoApplication
//
//  Created by IMCS2 on 2/19/19.
//  Copyright © 2019 IMCS2. All rights reserved.
//

import Foundation
import Firebase

class ToDoDatabase{
    
    
    var title : String=""
    var discription : String=""
    
    var ref : DatabaseReference!
    
    init(title:String , discription:String) {
        self.title = title
        self.discription = discription
       
    }
    
    
    func toDisctionary()->[String:String]{
        return[
            "title" : title,
            "discription" : discription
        ]
    }
    
    func saveDatabase(){
        FirebaseApp.configure()
        ref = Database.database().reference().child("User/ToDoTask").childByAutoId()
        ref.setValue(toDisctionary())
    }
    
    
    
}
