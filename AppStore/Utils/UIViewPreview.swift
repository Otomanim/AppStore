//
//  UIViewPreview.swift
//  AppStore
//
//  Created by Evandro Rodrigo Minamoto on 21/11/23.
//

import Foundation

#if canImport(SwiftUI) && DEBUG

import SwiftUI

struct UIViewPreview<View: UIView>: UIViewRepresentable {
    let view: View
    
    init(_ builder: @escaping () -> View) {
        view = builder()
    }
    
    func makeUIView(context: Context) -> View {
        view
    }
    
    func updateUIView(_ uiView: View, context: Context) {
        uiView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        uiView.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
    
}

#endif
