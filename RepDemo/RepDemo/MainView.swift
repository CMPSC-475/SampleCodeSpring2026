//
//  ContentView.swift
//  RepDemo
//
//  Created by Nader Alfares on 3/24/26.
//

import SwiftUI

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
            
            if isLoading {
                //TODO: Replace with UIActivityIndicator from UIKit
                ProgressView()
            }
        }
        .padding()
    }
}

#Preview {
    MainView()
}
