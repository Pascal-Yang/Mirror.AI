//
//  MsgBtnsView.swift
//  Mirror
//
//  Created by Ziqian Wang on 3/5/23.
//  Copyright © 2023 Duy Bui. All rights reserved.
//

import SwiftUI

struct MsgBtnsView: View {
    var body: some View {
        
        HStack{
            VStack (alignment: .center){
                Image("record")
                    .resizable()
                    .scaledToFit()
                    .frame(width:150)
                    .padding(10)
            }
            .background(Color("Purple3"))
            .frame(width:40, height:40)
            .cornerRadius(20)
            
            VStack (alignment: .center){
                Image("hint")
                    .resizable()
                    .scaledToFit()
                    .frame(width:150)
                    .padding(10)
            }
            .background(Color("Purple3"))
            .frame(width:40, height:40)
            .cornerRadius(20)
            
            VStack (alignment: .center){
                Image("answer")
                    .resizable()
                    .scaledToFit()
                    .frame(width:150)
                    .padding(10)
            }
            .background(Color("Purple3"))
            .frame(width:40, height:40)
            .cornerRadius(20)
        }
        
    }
}

struct MsgBtnsView_Previews: PreviewProvider {
    static var previews: some View {
        MsgBtnsView()
    }
}
