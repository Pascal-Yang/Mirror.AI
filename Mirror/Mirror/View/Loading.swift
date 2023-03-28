//
//  Loading.swift
//  Mirror
//
//  Created by Zhiyi Tang on 3/27/23.
//  Copyright © 2023 Duy Bui. All rights reserved.
//

import Foundation
import SwiftUI

struct LoadingView: View {
    let loading: Bool
    
    var body: some View {
        Group {
            if loading {
                VStack {
                    ActivityIndicator()
                        .frame(width: 50, height: 50)
                    Text("Loading...")
                        .font(.footnote)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white.opacity(0.7))
            } else {
                EmptyView()
            }
        }
    }
}

struct ActivityIndicator: UIViewRepresentable {
    
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: .large)
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<Self>) {
        if uiView.isAnimating {
            uiView.stopAnimating()
        } else {
            uiView.startAnimating()
        }
    }
}

