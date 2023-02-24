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
    
    @State private var selectedIndex: Int = -1
    @State private var text: String = "Google is an American multinational technology company that specializes in internet-related services and products, including search engines, online advertising technologies, cloud computing, software, and hardware."
    @Binding var selectedCompany: Company
    
    var body : some View{
        
        VStack {
            
            Spacer()

            
            VStack (alignment: .leading) {
                
                Spacer()
                
                HStack(spacing: 10){
                    
                    Image("google_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(Color(.white))
                        .padding()
                    
                    VStack(alignment: .leading){
                        Text("Google")
                            .foregroundColor(Color("Purple3"))
                            .font(.system(size: 25, weight: .bold))
                            .fontWeight(.bold)
                            .padding(.bottom, 5)
                        
                        Text("Google is an American multinational technology company that specializes in internet-related services and products.")
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
                .padding(.horizontal)

                HStack {
                    Spacer()
                    
                    RadioGroupPicker(selectedIndex: $selectedIndex, titles: Config.positions)
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
                    
                    Spacer()
                }

                Spacer()
                
            }
            .frame(height:550)
            .background(Color("Grey1"))
            .cornerRadius(50)
            .padding(.horizontal)
            
            NavigationLink(destination: ChatView()) {
                Text("Start Practicing")
                    .foregroundColor(.white)
                    .padding()
                    .font(.system(size: 15, weight: .medium))
                    .background(Color("Purple3"))
                    .cornerRadius(50)
            }
            .padding(.top, 30)
            .disabled(selectedIndex == -1)
            .opacity(selectedIndex != -1 ? 1.0 : 0.5)

            Spacer()

        }
        
    }
}

struct ConfigurationView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigurationView(selectedCompany: Binding.constant(Companies.Google))
    }
}
