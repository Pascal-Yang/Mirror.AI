//
//  ViewExtension.swift
//

import SwiftUI
//View extension for end editing
extension View {
    func endEditing(_ force: Bool) {
        UIApplication.shared.windows.forEach { $0.endEditing(force)}
    }
}
