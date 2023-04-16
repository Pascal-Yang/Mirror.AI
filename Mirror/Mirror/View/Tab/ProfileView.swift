//
//  ProfileView.swift
//  Mirror
//
//  Created by Zhiyi Tang on 4/9/23.
//  Copyright © 2023 Duy Bui. All rights reserved.
//

import Foundation
import SwiftUI
import Charts

struct ProfileView : View {
    
    @State private var avatar: String = DataSource.secondUser.avatar
    @State private var quesPerDay: String = "\(DataSource.secondUser.quesPerDay)"
    @State var circleOpacity: Double = 0.0
    @State var userDeleted = false
    
    @Environment(\.presentationMode) var presentationMode

    
    var body : some View{
        Spacer()
            .frame(maxHeight: 10)
        
        VStack(alignment: .center){
            
            ZStack(alignment: .top) {
                Rectangle()
                    .fill(Color("Purple1"))
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width / 2)

                ZStack(alignment: .center){
                    Circle()
                        .stroke(Color("Purple3").opacity(circleOpacity), lineWidth: 5)
                        .frame(width: 90, height: 90)
                    
                    Image(avatar)
                        .resizable()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                        .onTapGesture {
                            avatar = avatar == "myAvatar" ? "myAvatar2" : "myAvatar"
                            DataSource.secondUser.avatar = avatar // Update the data source with the new avatar value
                            if let uid = FirebaseManager.shared.auth.currentUser?.uid{
                                FirebaseManager.shared.setAvatarString(avatar: avatar, uid: uid)
                            }

                        }
                    
                }
                .padding(.top, UIScreen.main.bounds.width / 2 - 45)

            }
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 1.0).repeatForever()) {
                    circleOpacity = 0.5
                }
            }

            
            Spacer()
                .frame(height: 20)
            
            // TO-DO: change second-user name in DataSource
//            Text((FirebaseManager.shared.auth.currentUser?.email ?? "Guest"))
            Text(DataSource.secondUser.name)
                .font(.system(size: 30))
                .fontWeight(.bold)
                .padding(.bottom, 30)
                .foregroundColor(Color("Purple3"))

            VStack(alignment: .leading, spacing: 10) {
                Text("Email: \((FirebaseManager.shared.auth.currentUser?.email ?? "Guest@wustl.edu"))")
                    .foregroundColor(Color("Grey4"))
                    .font(.subheadline)
                    .font(.system(size: 25))
                    .fontWeight(.bold)
                HStack {
                    Text("Questions per day:")
                        .foregroundColor(Color("Grey4"))
                        .font(.subheadline)
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                    TextField("Enter value", text: $quesPerDay, onCommit: {
                        // Update the stored value when the user finishes editing
                        if let value = Int(quesPerDay) {
                            DataSource.secondUser.quesPerDay = value
                            if let uid = FirebaseManager.shared.auth.currentUser?.uid{
                                FirebaseManager.shared.setQuestionPerDay(value: value, uid: uid)
                            }
                        }
                    })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 100)
                }
                
                // delete user account
                if FirebaseManager.shared.auth.currentUser != nil{
                    Button("Delete Account"){
                        FirebaseManager.shared.deleteCurrentUser(){
                            self.presentationMode.wrappedValue.dismiss()
                        }
                        
                    }
                }
                
                
            }
            
            Spacer()

            
        }
        
        Spacer()
    }
}
