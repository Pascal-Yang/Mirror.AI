//
//  IntroSlide.swift
//  Mirror
//
//  Created by Zhiyi Tang on 3/28/23.
//  Copyright © 2023 Duy Bui. All rights reserved.
//

import Foundation
import RadioGroup
import SwiftUI

// configuration view
struct IntroSlide : View {
    
    let page: Guide
    @Binding var currentPage: Int

    var body : some View{
        
        VStack {
                        
            VStack (alignment: .center) {
                                
                Image(page.img)
                    .resizable()
                    .scaledToFit()
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                    .frame(width: 200)
                    .foregroundColor(Color(.white))
                    .padding(.bottom, 20)
                
                HStack{
                    Text(page.title)
                        .foregroundColor(Color("Purple3"))
                        .font(.system(size: 25, weight: .bold))
                        .fontWeight(.bold)
                        .padding(.bottom, 10)
                        .padding(.leading, 20)
                    Spacer()
                }
                
                Text(page.description)
                    .foregroundColor(Color("Grey3"))
                    .disabled(true)
                    .font(.system(size: 12, weight: .medium))
                    .lineLimit(nil)
                    .padding(.horizontal, 20)
                
            }
            .padding()

        }
        
    }
}

