//
//  ConfigurationView.swift
//  Mirror
//
//  Created by Zhiyi Tang on 2/23/23.
//  Copyright © 2023 Duy Bui. All rights reserved.
//

import Foundation
import RadioGroup
import SwiftUI

// configuration view
struct ConfigurationView : View {
    
    let page: ConfigPage
    @State private var selectedIndex: Int = -1
    @Binding var selectedCompany: Company
    @Binding var currentPage: Int

    
    var body : some View{
        
        VStack {
                        
            VStack (alignment: .leading) {
                                
                // only display company description when on the first config page
                if self.currentPage == 0 && selectedCompany != Companies.Default {
                                    
                    HStack(spacing: 10){
                        
                        Image(selectedCompany.logo)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .foregroundColor(Color(.white))
                            .padding()
                        
                        VStack(alignment: .leading){
                            Text(selectedCompany.name)
                                .foregroundColor(Color("Purple3"))
                                .font(.system(size: 25, weight: .bold))
                                .fontWeight(.bold)
                                .padding(.bottom, 5)
                            
                            Text(selectedCompany.description)
                                .foregroundColor(Color("Grey3"))
                                .disabled(true)
                                .font(.system(size: 12, weight: .medium))
                                .lineLimit(nil)
                            
                        }.padding(.vertical, 10)
                        
                        Spacer()
                                                
                    }
                    .frame(height:160)
                    .background(Color.white)
                    .cornerRadius(45)
                    .padding()
                    .onAppear() {
                        ConfigParam.append(selectedCompany.name)
                    }
                }

                HStack {
                    Spacer()
                    
                    if self.currentPage != pages.count - 1 {

                        RadioGroupPicker(selectedIndex: $selectedIndex, titles: pages[currentPage].options)
                            .selectedColor(Colors.Purple3)
                            .buttonSize(32)
                            .itemSpacing(80)
                            .spacing(12)
                            .titleColor(.black)
                            .titleAlignment(.left)
                            .environment(\.layoutDirection, .rightToLeft)
                            .fixedSize()
                            .padding(10)
                            .accentColor(Color("Grey3"))
                        
                    }
                    Spacer()

                }.onDisappear{
                    
                    if self.currentPage != pages.count - 1 || selectedIndex != -1 {
                        guard currentPage > 0 else {
                            return
                        }
                        if pages[currentPage - 1].options.count > selectedIndex && selectedIndex >= 0 {
                            ConfigParam.append(pages[currentPage - 1].options[selectedIndex])
                            print(ConfigParam)
                        }

                    }
                }
                
            }
            .frame(height: (self.currentPage == 0 && selectedCompany != Companies.Default) ? (200 + 56 * CGFloat(pages[currentPage].options.count)) : (56 * CGFloat(pages[currentPage].options.count))) // responsive to frame size to number of options in the radio group
            .background(Color("Grey1"))
            .cornerRadius(50)
            .padding(.horizontal)
            
            // if on last configuration page, show "Start Practicing" button
            if self.currentPage == pages.count - 1 {
                
                NavigationLink(destination: ChatView()) {
                    Text("Start Practicing")
                        .foregroundColor(.white)
                        .padding()
                        .font(.system(size: 15, weight: .medium))
                        .background(Color("Purple3"))
                        .cornerRadius(50)
                }
                .padding(.top, 30)
//                .disabled(selectedIndex == -1)
//                .opacity(selectedIndex != -1 ? 1.0 : 0.5)
                
            }

        }
        
    }
}

