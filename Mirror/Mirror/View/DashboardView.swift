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
