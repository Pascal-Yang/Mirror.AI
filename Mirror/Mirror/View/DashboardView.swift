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
    
    var body: some View {
                    
            VStack {
                
                Spacer()
                    .frame(maxHeight: 100)
                
                HStack{
                    
                    // TO-DO: change second-user name in DataSource
                    Text((FirebaseManager.shared.auth.currentUser?.email ?? "Guest"))
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                        .padding()
                        .foregroundColor(Color("Purple3"))
                    
                    
                    Spacer()

                    Image(DataSource.secondUser.avatar)
                        .resizable()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                        .padding(.top, 16)
                }
                .padding(.horizontal)
                Spacer()
                DashBlockView(selectedCompany: $selectedCompany)
                
            }.onAppear(){
                DataSource.secondUser.name = (FirebaseManager.shared.auth.currentUser?.email)!
            }
                        
        
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(selectedCompany: Companies.Google)
    }
}
