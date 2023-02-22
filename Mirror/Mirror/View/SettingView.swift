//
//  SettingView.swift
//  Mirror
//
//  Created by Zhiyi Tang on 2/11/23.
//  Copyright © 2023 Duy Bui. All rights reserved.
//

import Foundation

import SwiftUI

struct SettingView: View {
    
    @State var selected = ""
    @State var show = false
    
    var body: some View {
        
        ZStack{
            
            VStack{
                
                Button(action: {
                    
                    self.show.toggle()
                    
                }) {
                    
                Text("Company Name").padding(.vertical).padding(.horizontal,25).foregroundColor(.white)
                }
                .background(LinearGradient(gradient: .init(colors: [Color("Purple1"),Color("Purple2")]), startPoint: .leading, endPoint: .trailing))
                .clipShape(Capsule())
                
                Text(self.selected).padding(.top)
            }
            
            VStack{
                
                Spacer()
                
                RadioButtons(selected: self.$selected,show: self.$show).offset(y: self.show ? (UIApplication.shared.windows.last?.safeAreaInsets.bottom)! + 15 : UIScreen.main.bounds.height)
                
            }.background(Color(UIColor.label.withAlphaComponent(self.show ? 0.2 : 0)).edgesIgnoringSafeArea(.all))
            
        }.background(Color("Purple1").edgesIgnoringSafeArea(.all))
        .animation(.default)
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}

struct RadioButtons : View {
    
    @Binding var selected : String
    @Binding var show : Bool
    
    var body : some View{
        
        VStack(alignment: .leading, spacing: 20) {
            
            Text("Company Name").font(.system(size: 28, weight: .bold))
                .padding(.top).foregroundColor(Color("Purple2"))
            
            Text("Company description placeholder").font(.body).padding(.bottom)
            
            ForEach(data,id: \.self){i in
                
                Button(action: {
                    
                    self.selected = i
                    
                }) {
                    
                    HStack{
                        
                        Text(i)
                        
                        Spacer()
                        
                        ZStack{
                            
                            Circle().fill(self.selected == i ? Color("Grey3") : Color.black.opacity(0.2)).frame(width: 18, height: 18)
                            
                            if self.selected == i{
                                
                                Circle().stroke(Color("Purple1"), lineWidth: 4).frame(width: 25, height: 25)
                            }
                        }
                        

                        
                    }.foregroundColor(.black)
                    
                }.padding(.top)
            }
            
            HStack{
                
                Spacer()
                
                 Button(action: {
                     
                    self.show.toggle()
                    
                 }) {
                     
                     Text("Start Practice").padding(.vertical).padding(.horizontal,25).foregroundColor(.white)
                     
                 }
                 .background(
                    
                    self.selected != "" ?
                    
                    LinearGradient(gradient: .init(colors: [Color("Purple1"),Color("Purple2")]), startPoint: .leading, endPoint: .trailing) :
                    
                        LinearGradient(gradient: .init(colors: [Color.black.opacity(0.2),Color.black.opacity(0.2)]), startPoint: .leading, endPoint: .trailing)
                 
                 )
                .clipShape(Capsule())
                .disabled(self.selected != "" ? false : true)
                
                
            }.padding(.top)
            
        }.padding(.vertical)
        .padding(.horizontal,25)
        .padding(.bottom,(UIApplication.shared.windows.last?.safeAreaInsets.bottom)! + 15)
        .background(Color.white)
        .cornerRadius(30)
    }
}

var data = ["Software Engineer","Data Scientist","DevOps Engineer","Product Manager","UI/UX Designer","Systems Administrator", "Others"]
