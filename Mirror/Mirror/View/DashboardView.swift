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
        
        ZStack{
            Color.gray.opacity(0.15).edgesIgnoringSafeArea(.all)
                
            ZStack{
                VStack {
                    Spacer(minLength: 220)
                    Color.white
                        .edgesIgnoringSafeArea(.all)
                        .frame(width: UIScreen.main.bounds.size.width, height:550, alignment: .bottom)
                }
                VStack {
                    Spacer()
                    DashBlockView(selectedCompany: $selectedCompany)
                }
            }
                
        }
        
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(selectedCompany: Companies.Google)
    }
}
