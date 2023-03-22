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
        
        NavigationView{
            
            VStack {
                
                Spacer()
                    .frame(maxHeight: 100)
                
                HStack{
                    Text(DataSource.secondUser.name)
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
                
            }

        }
        .navigationBarTitle(Text("Dashboard"), displayMode: .automatic)
        .background(Color(.systemGroupedBackground))
        
        
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(selectedCompany: Companies.Google)
    }
}
