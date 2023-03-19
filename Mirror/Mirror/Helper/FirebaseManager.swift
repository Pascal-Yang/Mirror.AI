//
//  FirebaseManager.swift
//  Mirror
//
//  Created by Pascal Yang on 3/18/23.
//  Copyright © 2023 Duy Bui. All rights reserved.
//

import Foundation
import Firebase
import FirebaseCore
import FirebaseFirestore

class FirebaseManager: NSObject{
    
    let auth: Auth
    let db: Firestore
    
    static let shared = FirebaseManager()
    
    override init() {
        
        // congfigue firestore app
        FirebaseApp.configure()
        
        // initialized shared util obj
        self.db = Firestore.firestore()
        self.auth = Auth.auth()
        
        super.init()
    }
    
    // store a new record to the current user
    func storeChatHistory(content:String, type:Int){
        
        if let user = auth.currentUser{
            let uid = user.uid
            
            let docData: [String:Any] = [
                "content":content,
                "type": type,
                "time": Timestamp(date: Date())
            ]
            
            db.collection("chat_history").document(uid).collection("chat_records").addDocument(data: docData){ err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Record successfully written!")
                }
            }
            
        }else{
            print("You have not logged in!")
        }
    }
    
    // return an array of ChatRecord of the current loggin user
    func getChatHistory()->[ChatRecord]{
        var result:[ChatRecord] = []
        
        if let user = auth.currentUser{
            let collection = db.collection("chat_history").document(user.uid).collection("chat_records")
            collection.getDocuments{
                (qSnapshot, error) in
                if let e = error{
                    print("cannot fetch data with uid", user.uid, e)
                }else{
                    for doc in qSnapshot!.documents{
                        
                        let type:Int = doc.data()["type"]! as! Int
                        let content:String = doc.data()["content"]! as! String
                        let time:Date = (doc.data()["time"] as! Timestamp).dateValue()
                        
                        print(type, content, time)
                        
                        let newRecord = ChatRecord(content: content, type: type, time: time)
                        result.append(newRecord)
                    }
                }
            }
            
        }else{
            print("You have not logged in!")
        }
        
        return result
    }
}
