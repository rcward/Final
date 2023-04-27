//
//  ActivityIndicator.swift
//  Final Project
//
//  Created by user230914 on 4/25/23.
//

import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
    typealias UIViewType = UIActivityIndicatorView
    @Binding var isAnimating: Bool
    var style: UIActivityIndicatorView.Style

    func makeUIView(context: Context) -> UIViewType {
        let indicator = UIActivityIndicatorView(style: style)
        return indicator
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

