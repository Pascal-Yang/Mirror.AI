//
//  TabView.swift
//  Mirror
//
//  Created by Zhiyi Tang on 4/7/23.
//  Copyright © 2023 Duy Bui. All rights reserved.
//

import Foundation
import AxisTabView
import SwiftUI

struct CustomTabView : View {
    
    @State private var selection: Int = 0
    @State private var constant = ATConstant(axisMode: .bottom, screen: .init(activeSafeArea: false), tab: .init())
    @State private var radius: CGFloat = 60
    @State private var concaveDepth: CGFloat = 0.90
    @State private var color: Color = .white
    @State var selectedCompany : Company = Companies.Default

    private let pageTitles = ["Practice", "Practice History", "Profile Settings"]
    
    var body : some View{
        
        GeometryReader { proxy in
            AxisTabView(selection: $selection, constant: constant) { state in
                ATCurveStyle(state, color: color, radius: radius, depth: concaveDepth)
            } content: {
                DashBlockView(selectedCompany: $selectedCompany)
                    .tabItem(tag: 0, normal: {
                        Image(systemName: "house")
                            .foregroundColor(.gray)

                    }, select: {
                        Image(systemName: "house.fill")
                            .foregroundColor(Color("Purple2"))
                    })
                DataView()
                    .tabItem(tag: 1, normal: {
                        Image(systemName: "calendar")
                            .foregroundColor(.gray)
                    }, select: {
                        Image(systemName: "calendar")
                            .foregroundColor(Color("Purple2"))
                    })
                EmptyView() //TODO: to be replaced with profile view
                    .tabItem(tag: 2, normal: {
                        Image(systemName: "person")
                            .foregroundColor(.gray)
                    }, select: {
                        Image(systemName: "person.fill")
                            .foregroundColor(Color("Purple2"))
                    })
            } onTapReceive: { selectionTap in
                /// Imperative syntax
                print("---------------------")
                print("Selection : ", selectionTap)
                print("Already selected : ", self.selection == selectionTap)
            }
        }
        .animation(.easeInOut, value: constant)
        .animation(.easeInOut, value: radius)
        .animation(.easeInOut, value: concaveDepth)
        .navigationTitle(pageTitles[selection])
        
    }
    
    
}
