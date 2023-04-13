//
//  ChartView.swift
//  Mirror
//
//  Created by Zhiyi Tang on 4/11/23.
//  Copyright © 2023 Duy Bui. All rights reserved.
//

import Foundation
import SwiftUI
import AxisContribution

struct ChartView : View {

    @State var rowSize:CGFloat = 30.0
    @State var rowImageName:String = "square.fill"
    @State var dateList:[Date] = globalQuestionList.compactMap { $0.time }
    @State var loading: Bool = false

    var body : some View{

        ZStack{
            
            if DataSource.secondUser.name != "Guest" {
                VStack{
                    AxisContribution(constant: .init(axisMode: .vertical), source: dateList){ indexSet, data in
                        Image(systemName: rowImageName)
                            .foregroundColor(Color("Grey1"))
                            .font(.system(size: rowSize))
                            .frame(width: rowSize, height: rowSize)
                    } foreground: { indexSet, data in
                        Image(systemName: rowImageName)
                            .foregroundColor(Color("Purple3"))
                            .font(.system(size: rowSize))
                            .frame(width: rowSize, height: rowSize)
                    }
                    .onAppear(){
                        print(dateList)
                        
                        loading = true
                        FirebaseManager.shared.getQuestionsWithCallBack{result in
                            globalQuestionList = result
                            dateList = globalQuestionList.compactMap { $0.time }
                            loading = false
                        }
                        
                    }
                    
                    PickerView(rowSize: $rowSize, rowImageName: $rowImageName)
                }
                .padding(20)
                .padding(.bottom, 80)
                
                
                LoadingView(loading: loading)
                
            } else {
                
                Text("Please log in to view")
                    .font(.caption)
                    .fontWeight(.bold)
                    .padding()
                    .foregroundColor(Color("Purple3"))
            }
        }

    }
    
}


struct PickerView: View {
    
    @Binding var rowSize:CGFloat
    @Binding var rowImageName:String
    
    var body: some View {
        Spacer()
        Picker("", selection: $rowImageName) {
            Text("Default").tag("square.fill")
            Image(systemName: "heart.fill").tag("heart.fill")
            Image(systemName: "flame.fill").tag("flame.fill")
            Image(systemName: "seal.fill").tag("seal.fill")
        }
        .pickerStyle(.segmented)
        HStack {
            Text("Row Size : ")
                .foregroundColor(Color("Purple3"))
                .font(.footnote)
                .fontWeight(.bold)
            
            Slider(value: $rowSize, in: 11...40)
                .foregroundColor(Color("Purple3"))
            
            Text("\($rowSize.wrappedValue, specifier: "%.2f")")
                .foregroundColor(Color("Purple3"))
                .font(.footnote)

        }
        .pickerStyle(.segmented)
//            Button("Refresh Dates") {
//                dates = getDates()
//            }
//            .padding()
        
    }
}

