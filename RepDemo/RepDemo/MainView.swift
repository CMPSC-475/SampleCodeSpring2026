//
//  ContentView.swift
//  RepDemo
//
//  Created by Nader Alfares on 3/24/26.
//

import SwiftUI
import UIKit

struct ActivityIndicatorView: UIViewRepresentable {
    var isAnimating: Bool = false
    
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.startAnimating( )
        return indicator
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        if isAnimating {
            uiView.startAnimating()
        } else {
            uiView.stopAnimating()
        }
    }
    
    
}



struct MainView: View {
    
    @State var isLoading : Bool = false
    var body: some View {
        VStack {
            Button {
                isLoading.toggle()
            } label : {
                Text(isLoading ? "Stop Loading" : "Start Loading")
                    .font(Font.largeTitle.bold())
            }
            ActivityIndicatorView(isAnimating: isLoading)
        }
        .padding()
    }
}

#Preview {
    MainView()
}
