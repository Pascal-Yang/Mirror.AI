//
//  LoginPage.swift
//  Mirror
//
//  Created by Pascal Yang on 3/17/23.
//  Copyright © 2023 Duy Bui. All rights reserved.
//

import SwiftUI

struct LoginPage: View {
    @State var isLoginMode = true
    @State var email = ""
    @State var password = ""
    @State var isLogined = false {
        didSet{
            print("isLogined = \(isLogined)")
        }
    }
    @State var displayAlert = false
    @State var alertMessage = ""
    @State private var isButton1Selected = false
    @State private var isButton2Selected = false

    var body: some View {
        
        NavigationView{
            
            ScrollView{
                
                VStack(spacing: 20){
                    Spacer()
                    
                    Text("Welcome!")
                        .font(.system(size: 28))
                        .fontWeight(.bold)
                        .padding()
                        .foregroundColor(Color("Purple3"))
                    
                    
                    Picker(selection: $isLoginMode, label: Text("Picker is here")){
                        Text("Login").tag(true)
                        Text("Create Account").tag(false)
                    }.pickerStyle(SegmentedPickerStyle())
                    
                    
                    if !isLoginMode {

                        HStack {
                            Button(action: {
                                isButton1Selected = true
                                isButton2Selected = false
                                DataSource.secondUser.avatar = "myAvatar"
                            }) {
                                Image("myAvatar")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .clipShape(Circle())
                                    .overlay(
                                        Circle().stroke(Color("Purple2"), lineWidth: isButton1Selected ? 3 : 0)
                                    )
                                    .padding(.top, 16)
                            }
                            Spacer().frame(width: 20)
                            
                            Button(action: {
                                isButton1Selected = false
                                isButton2Selected = true
                                DataSource.secondUser.avatar = "myAvatar2"

                            }) {
                                Image("myAvatar2")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .clipShape(Circle())
                                    .overlay(
                                        Circle().stroke(Color("Purple2"), lineWidth: isButton2Selected ? 3 : 0)
                                    )
                                    .padding(.top, 16)
                            }
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
                            }.background(Color("Purple3"))
                        }
                        .alert(isPresented: $displayAlert){
                            Alert(
                                title: Text("Error"),
                                message: Text(alertMessage),
                                dismissButton: .default(Text("OK"))
                            )
                        }
                        .cornerRadius(10)
                        
                        Button("Continue as Guest") {
                            isLogined = true
                        }
                        .buttonStyle(PlainButtonStyle())
                        .foregroundColor(Color("Purple3"))
                        .padding(.top, 20)
                        .background(
                            NavigationLink(destination: DashboardView(selectedCompany: Companies.Google), isActive: $isLogined) {
                                EmptyView()
                            }
                        )
                        
                        Spacer()

                        
                    }
                    .background(
                        NavigationLink(destination: DashboardView(selectedCompany: Companies.Google), isActive: $isLogined){
                            EmptyView()
                        }
                    )
                    
                }
                .padding()
                .onAppear(perform: {
                    if isLogined{
                        do{
                            try FirebaseManager.shared.auth.signOut()
                        }catch{
                            print(error)
                        }
                        isLogined = false
                        email = ""
                        password = ""
                    }
                    
                })
                
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
                alertMessage = err.localizedDescription
                displayAlert = true
                print(err.localizedDescription)
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
                alertMessage = err.localizedDescription
                displayAlert = true
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
