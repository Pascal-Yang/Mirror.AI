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
    @Binding var selectedCompany: Company

    let pages: [ConfigPage]
    
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
                        self.currentPage = (self.currentPage + 1) % self.pages.count
                    }
                }) {
                    if self.currentPage != self.pages.count - 1{
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
