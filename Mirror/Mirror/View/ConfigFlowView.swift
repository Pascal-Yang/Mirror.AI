//
//  ConfigFlowView.swift
//  Mirror
//
//  Created by Zhiyi Tang on 2/23/23.
//  Copyright © 2023 Duy Bui. All rights reserved.
//

import Foundation

import SwiftUI


var ConfigParam: [String] = []

struct ConfigFlowView : View {
    
    @State private var currentPage = 0
    @State var selectedCompany: Company
    
    var body: some View {
        
        VStack {
        
            ConfigurationView(page: pages[self.currentPage], selectedCompany: $selectedCompany, currentPage: $currentPage)
                .transition(AnyTransition.pageTransition)
                .id(self.currentPage)
        
            HStack {
                
                Spacer()
                
                // transits to next config page if not last
                Button(action: {
                    withAnimation (.easeInOut(duration: 1.0)) {
                        self.currentPage = (self.currentPage + 1) % pages.count
                    }
                }) {
                    
                    // TODO: right now the user can proceed to next page w/o choosing an option, the chatroom will be configured without that particular parameter; for future enhancement, either add a default option in each RadioGroup or disable user from proceeding w/o choosing
                    
                    if self.currentPage != pages.count - 1{
                        Image(systemName: "arrow.right")
                            .font(.title)
                            .foregroundColor(Color.white)
                            .padding()
                            .background(Circle().fill(Color("Purple3")))
                        
                    } 
                }
                
                Spacer()
            }
            .padding()
            .onAppear{
                ConfigParam = []
            }
    
        }
        
        
    }
}
