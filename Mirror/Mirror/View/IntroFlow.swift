//
//  IntroFlow.swift
//  Mirror
//
//  Created by Zhiyi Tang on 3/28/23.
//  Copyright © 2023 Duy Bui. All rights reserved.
//

import Foundation
import SwiftUI


struct IntroFlow : View {
    
    @State private var currentPage = 0
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    
    var body: some View {
        
        VStack {
        
            IntroSlide(page: introSlides[self.currentPage], currentPage: $currentPage)
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
    
                    if self.currentPage != pages.count - 1{
                        
                        
                        Text("Continue")
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            .background(
                                Capsule()
                                    .fill(Color("Purple3"))
                                    .frame(height: 45)
                            )
                        
                    } else {
                        
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Done")
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 20)
                                .background(
                                    Capsule()
                                        .fill(Color("Purple3"))
                                        .frame(height: 45)
                                )
                            
                        }
                    }
                    
                }
                
                Spacer()
            }
            .padding()
            .onAppear{
                ConfigParam = [:]
            }
    
        }
        
        
    }
}


