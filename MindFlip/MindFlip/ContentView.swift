//
//  ContentView.swift
//  MindFlip
//
//  Created by Nader Alfares on 1/13/26.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        
        
        
        ZStack {
            Color.cyan
                .ignoresSafeArea(edges: .all)
            
            
            VStack {
                
                Text("MindFlip")
                HStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 25.0)
                            .foregroundStyle(Color.orange)
                        Text("Missed")
                    }
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 25.0)
                            .foregroundStyle(Color.green)
                        Text("Missed")
                    }
                }
                ForEach(1...4, id: \.self) { index1 in
                    HStack {
                        ForEach(1...4, id: \.self) { index2 in
                            RoundedRectangle(cornerRadius: 25.0)
                        }
                        
                    }
                }
                
                
                Button {
                    
                } label: {
                    Text("New Game")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .background(Color.purple)
                    
                }

            }
            .padding()
        }
    }
}

#Preview {
    MainView()
}
