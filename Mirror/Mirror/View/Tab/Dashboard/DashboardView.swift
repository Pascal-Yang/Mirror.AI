//
//  DashboardView.swift
//  Mirror
//
//  Created by Zhiyi Tang on 2/23/23.
//  Copyright © 2023 Duy Bui. All rights reserved.
//

import Foundation

import SwiftUI

// view for configuration page (before AI chatroom session)
struct DashboardView: View {
    
    @State var selectedCompany : Company
    @State var userName:String?
    @State var avatarString:String?
    @State var selection : Int = 0
    var body: some View {
                    
            VStack {
            
                CustomTabView()
                    .ignoresSafeArea(.keyboard) // use the ignoresSafeArea(.keyboard) modifier

                
            }.onAppear(){
                if (FirebaseManager.shared.auth.currentUser?.email) != nil {
                    
                } else {
                    DataSource.secondUser.name = "Guest";
                }
            }.navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: CustomBackButton())
            .navigationBarItems(trailing:
                NavigationLink(destination: IntroFlow()) {
                    Image(systemName: "lightbulb")
                        .foregroundColor(Color("Purple3"))
                }
            )
                        
        
    }
}

struct CustomBackButton: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "arrowshape.turn.up.backward")
                    .foregroundColor(.red)
                Text("Logout")
                    .foregroundColor(.red)
            }
        }
    }
}

//struct DashboardView_Previews: PreviewProvider {
//    static var previews: some View {
//        DashboardView(selectedCompany: Companies.Google)
//    }
//}
