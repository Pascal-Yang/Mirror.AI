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

var questionList : [Conversation] = []
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
    
    func setQuestionPerDay(value:Int, uid:String){
        let docRef = db.collection("chat_history").document(uid)
        docRef.setData(["questionPerDay":value], merge:true){err in
            if let e = err{
                print("error in changing questionPerDay", e)
            }else{
                print("questionPerDay changed to", value)
            }
        }
    }
    
    func getQuestionPerDayWithCallBack(completion: @escaping (Int)->Void){
        if let user = auth.currentUser{
            let uid = user.uid
            db.collection("chat_history").document(uid).getDocument(){(result, error) in
                if let e = error{
                    print("When getting Q per day: ", e)
                }else if let doc = result{
                    print(doc.data()!)
                    let docDict = doc.data()!
                    if let ret = docDict["questionPerDay"] as? Int{
                        completion(ret)
                    }else{
                        print("cannot find question perday in user data =>", docDict)
                    }
                    
                }
            }
        }else{
            print("Cannot find user name since not logined")
        }
    }
  
    func setAvatarString(avatar:String, uid:String){
        let docRef = db.collection("chat_history").document(uid)
        docRef.setData(["avatar":avatar], merge:true){err in
            if let e = err{
                print("error in changing avatar", e)
            }else{
                print("avatar changed to", avatar)
            }
        }
    }
    
    func getAvatarStringWithCallBack(completion: @escaping (String)->Void){
        if let user = auth.currentUser{
            let uid = user.uid
            db.collection("chat_history").document(uid).getDocument(){(result, error) in
                if let e = error{
                    print("When avatar: ", e)
                }else if let doc = result{
                    let ret = doc.data()!["avatar"] as! String
                    completion(ret)
                }
            }
        }else{
            print("Cannot find user name since not logined")
        }
    }
    
    func getUserNameWithCallBack(completion: @escaping (String)->Void){
        if let user = auth.currentUser{
            let uid = user.uid
            db.collection("chat_history").document(uid).getDocument(){(result, error) in
                if let e = error{
                    print("When avatar: ", e)
                }else if let doc = result{
                    let ret = doc.data()!["userName"] as! String
                    completion(ret)
                }
            }
        }else{
            print("Cannot find user name since not logined")
        }
    }
 
    
    // 1. Add a new question into the database
    // 2. Update currentQuestionID to the newly creatd question
    // 3. How to call: FirebaseManager.shared.startNewQuestion()
    func startNewQuestion(job:String, question:String, answer:String, score:String){
        
        print("Starting a new question =>", job, "=>" ,question)
        
        if let user = auth.currentUser{
            let uid = user.uid
            print("current id: ", uid)
            
            let docData: [String:Any] = [
                "job":job,
                "question": question,
                "answer": answer,
                "score": score,
                "time": Timestamp(date: Date())
            ]
            
            print("======== Doc Data =========")
            print(docData)
            print("======== Doc Data =========")
            
            
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
                        for arr in currentHis{
                            //addHistoryToCurrentQuestion(role: arr["role"] as! String, content: arr["content"] as! String)
                            let tmpData: [String:Any] = [
                                "role":arr["role"] as! String,
                                "content": arr["content"] as! String,
                                "time": Timestamp(date: Date())
                            ]
                            
                            
                            self.db.collection("chat_history")
                                .document(uid)
                                .collection("questions")
                                .document(doc.documentID)
                                .collection("history")
                                .addDocument(data: tmpData){ err in
                                if let err = err {
                                    print("Error writing document: \(err)")
                                } else {
                                    print("History Added: ", arr["role"] as! String, arr["content"] as! String)
                                }
                            }
                        }
              
                        currentHis = [["role": "system", "content": "You are a helpful assistant."]]
                        currentAns = ""
                        currentScore = "0"
                        currentQues = ""
                    }else{
                        print("New question document is not created...")
                    }
                }
            }
            
            
            
        }else{
            print("You have not logged in!")
        }
    }
    
    // 1. Add a new history into the current question
    // 2. How to call: FirebaseManager.shared.addHistoryToCurrentQuestion()
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
    
    
    //    Question out put format:
    
    //    struct Conversation : Identifiable {
    //        var id = UUID()
    //        let question: String
    //        let score: Int
    //        let answer: String
    //        let time: Date
    //    }
    
    func getQuestionsWithCallBack(completion: @escaping ([Conversation]) -> Void){
        var ret:[Conversation] = []
        if let uid = auth.currentUser?.uid{
            db.collection("chat_history")
                .document(uid)
                .collection("questions")
                .getDocuments{ (res, err) in
                    if let e = err{
                        print("getQuestionsWithCallBack() =>", e)
                        return
                    }
                    
                    for doc in res!.documents{
                        let docAsDict = doc.data()
                        let curQuestion = Conversation(//id: UUID(uuidString: doc.documentID)!,
                                                       question: docAsDict["question"] as? String ?? "Empty Question",
                                                       score: docAsDict["score"] as? String ?? "N/A",
                                                       answer: docAsDict["answer"] as? String ?? "Empty Answer",
                                                       time: (docAsDict["time"] as? Timestamp)? .dateValue() ?? Date())
//                        print(curQuestion)
                        ret.append(curQuestion)
                    }
//                    print("fetch finished => ",ret)
                    completion(ret)
                    
                }
        }else{
            print("cannot fetch questions without login")
        }
       
    }
    
    // Return a list of all questions of the current user
    // Refer to structure of question and history in message.swift
//    func getQuestionsOfUser(){
//        
//        if let user = auth.currentUser{
//            let uid = user.uid
//            let ref = db.collection("chat_history")
//                .document(uid)
//                .collection("questions")
//            
//
//                ref.getDocuments{
//                    (res, err) in
//                    if let e = err{
//                        print(e)
//                    }else{
//                        for document in res!.documents {
//                            let tmp = document.data()
//                            if String(describing: tmp["question"]) != "" {
//                                let tmpConversation = Conversation(question: String(describing: tmp["question"] ?? ""), score: tmp["score"] as? Int ?? 0, answer: String(describing: tmp["answer"] ?? ""), time: tmp["time"] as? Date ?? Date())
//                                
//                                questionList.append(tmpConversation)
//                                
//                            }
//                        }
//                        
//                    }
//                }
//            
//            
//            
//        }else{
//            print("You have not signed in.")
//        }
//        
//    }
    
    
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
