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
    var currentQuestionID: String{
        didSet{
            print("currentQuestionID => \(currentQuestionID)")
        }
    }
    
    static let shared = FirebaseManager()
    
    override init() {
        
        // congfigue firestore app
        FirebaseApp.configure()
        
        // initialized shared util obj
        self.db = Firestore.firestore()
        self.auth = Auth.auth()
        self.currentQuestionID = ""
        
        super.init()
    }
    
    // log out the current user
    func logout(){
        do {
            try auth.signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    
    // 1. Add a new question into the database
    // 2. Update currentQuestionID to the newly creatd question
    func startNewQuestion(job:String, question:String){
        
        print("Starting a new question =>", job, "=>" ,question)
        
        if let user = auth.currentUser{
            let uid = user.uid
            print("current id: ", uid)
            
            let docData: [String:Any] = [
                "job":job,
                "question": question,
                "time": Timestamp(date: Date())
            ]
            
            var ref: DocumentReference? = nil
            ref = db.collection("chat_history")
                .document(uid)
                .collection("questions")
                .addDocument(data: docData){ err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Record successfully written!")
                    
                    //update current question id
                    if let doc = ref{
                        self.currentQuestionID = doc.documentID
                    }else{
                        print("New question document is not created...")
                    }
                }
            }
            
        }else{
            print("You have not logged in!")
        }
    }
    
    // add a new history into the current question
    func addHistoryToCurrentQuestion(role:String, content:String){
        
        print("Adding new history to qeustion =>", self.currentQuestionID)
        
        if let user = auth.currentUser{
            let uid = user.uid
            
            let docData: [String:Any] = [
                "role":role,
                "content": content,
                "time": Timestamp(date: Date())
            ]
            
            
            db.collection("chat_history")
                .document(uid)
                .collection("questions")
                .document(self.currentQuestionID)
                .collection("history")
                .addDocument(data: docData){ err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("History Added: ", content, role)
                }
            }
            
        }else{
            print("You have not logged in!")
        }
    }
    
    func getQuestionsOfUser()->[Question]{
        
        var questionList:[Question] = []
        
        if let user = auth.currentUser{
            let uid = user.uid
            db.collection("chat_history")
                .document(uid)
                .collection("questions")
                .getDocuments{
                    (res, err) in
                    if let e = err{
                        print(e)
                    }else{
                        for question in res!.documents{
                            var historyList:[History] = []
                            
                            let questionID = question.documentID
                            
                            self.db.collection("chat_history")
                                .document(uid)
                                .collection("questions")
                                .document(questionID)
                                .collection("history")
                                .getDocuments{
                                (res, err) in
                                if let e = err{
                                    print(e)
                                }else{
                                    for hist in res!.documents{
                                        var curHistory = History(content: hist.data()["content"] as! String,
                                                                 role: hist.data()["role"] as! String)
                                        print(curHistory.role, curHistory.content)
                                        historyList.append(curHistory)
                                    }
                                }
                            }
                            
                            var curQuestion = Question(job: question.data()["job"] as! String,
                                                       question: question.data()["question"] as! String,
                                                       history: historyList)
                            print(curQuestion.job, curQuestion.question)
                            questionList.append(curQuestion)
                        }
                    }
                }
        }else{
            print("You have not signed in.")
        }
        
        return questionList
    }
    
    
//    // store a new record to the current user
//    func storeChatHistory(content:String, type:Int){
//
//        if let user = auth.currentUser{
//            let uid = user.uid
//
//            let docData: [String:Any] = [
//                "content":content,
//                "type": type,
//                "time": Timestamp(date: Date())
//            ]
//
//            db.collection("chat_history").document(uid).collection("chat_records").addDocument(data: docData){ err in
//                if let err = err {
//                    print("Error writing document: \(err)")
//                } else {
//                    print("Record successfully written!")
//                }
//            }
//
//        }else{
//            print("You have not logged in!")
//        }
//    }
//
//    // return an array of ChatRecord of the current loggin user
//    func getChatHistory()->[ChatRecord]{
//        var result:[ChatRecord] = []
//
//        if let user = auth.currentUser{
//            let collection = db.collection("chat_history").document(user.uid).collection("chat_records")
//            collection.getDocuments{
//                (qSnapshot, error) in
//                if let e = error{
//                    print("cannot fetch data with uid", user.uid, e)
//                }else{
//                    for doc in qSnapshot!.documents{
//
//                        let type:Int = doc.data()["type"]! as! Int
//                        let content:String = doc.data()["content"]! as! String
//                        let time:Date = (doc.data()["time"] as! Timestamp).dateValue()
//
//                        print(type, content, time)
//
//                        let newRecord = ChatRecord(content: content, type: type, time: time)
//                        result.append(newRecord)
//                    }
//                }
//            }
//
//        }else{
//            print("You have not logged in!")
//        }
//
//        return result
//    }
}
