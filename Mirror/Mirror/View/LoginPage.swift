//
//  LoginPage.swift
//  Mirror
//
//  Created by Pascal Yang on 3/17/23.
//  Copyright © 2023 Duy Bui. All rights reserved.
//

import SwiftUI

struct LoginPage: View {
    @State var isLoginMode = false
    @State var email = ""
    @State var password = ""
    @State var isLogined = false
    
    var body: some View {
        
        NavigationView{
            ScrollView{
                
                
                
                VStack(spacing: 20){
                    Text("Authentication Page")
                        .fontWeight(.heavy)
                        
                    
                    Picker(selection: $isLoginMode, label: Text("Picker is here")){
                        Text("Login").tag(true)
                        Text("Create Account").tag(false)
                    }.pickerStyle(SegmentedPickerStyle())
                    
                    if !isLoginMode {
                        Button{}label: {
                            
                            Image(systemName: "person.fill")
                                .font(.system(size: 64))
                                .padding()
                                .foregroundColor(.blue)
                            
                        }
                    }
                    
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .padding(12)
                    SecureField("Password", text: $password)
                        .padding(12)
                    
                    VStack{
                        Button{
                            handleButton()
                        }label: {
                            HStack{
                                Spacer()
                                Text(isLoginMode ? "Log In" : "Create Account")
                                    .foregroundColor(.white)
                                    .padding(.vertical, 8)
                                Spacer()
                            }.background(Color.blue)
                        }
                        .cornerRadius(10)
                    }
                    .background(
                        NavigationLink(destination: DashboardView(selectedCompany: Companies.Google), isActive: $isLogined){
                            EmptyView()
                        }
                    )
                    
                   
                    
                }
                .padding()
                
            }
            
        }
        
    }
    
    private func handleButton(){
        if isLoginMode{
            
            loginAccount()
        }else{
            
            createAccount()
        }
    }
    
    private func loginAccount(){
        print("Login is called...")
        FirebaseManager.shared.auth.signIn(withEmail: email, password: password){
            res, error in
            if let err = error{
                print("cannot login", err)
                return
            }
            
            print("login successful", email, res?.user.uid ?? "cannot get uid")
            
            isLogined = true
            
            //FirebaseManager.shared.getChatHistory()
            
//
//            FirebaseManager.shared.addHistoryToCurrentQuestion(role: "user", content: "I user SwiftUI the best. But I also use Object-C.")
//            FirebaseManager.shared.addHistoryToCurrentQuestion(role: "assistant", content: "I can give hint.")
//
//            FirebaseManager.shared.getQuestionsOfUser()
            
        }
    }
    
    private func createAccount(){
        print("Register is called...")
        FirebaseManager.shared.auth.createUser(withEmail: email, password: password){
            res, error in
            if let err = error{
                print("register failed with \(err)")
                return
            }
            
            print("register successed: \(res?.user.uid ?? "cannot get uid")")
            
            // add document to the firebase for the new user
            let collection = FirebaseManager.shared.db.collection("chat_history")
            collection.document(res!.user.uid).setData([
                "uid": res!.user.uid,
                "email": email,
            ])
            
//            loginAccount()
                
            //FirebaseManager.shared.storeChatHistory(content: "Hello human.", type: 1)
            
            FirebaseManager.shared.startNewQuestion(job: "Software Engineer", question: "What is your fav coding laguage?")

      
//            FirebaseManager.shared.startNewQuestion(job: "Data Scientist", question: "How do you analyze data?")
//            FirebaseManager.shared.addHistoryToCurrentQuestion(role: "user", content: "I don't know how.")
//            FirebaseManager.shared.addHistoryToCurrentQuestion(role: "assistant", content: "I won't give hint.")
            
        }
    }
    
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}
