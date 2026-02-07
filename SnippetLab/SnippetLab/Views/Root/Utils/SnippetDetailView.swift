//
//  SnippetDetailView.swift
//  SnippetLab
//
//  Created by Nader Alfares on 2/6/26.
//
import SwiftUI

struct SnippetDetailView<DemoContent: View>: View {
    var snippet: Snippet
    var demoCode: () -> DemoContent
    
    
    @State var showDemoCode : Bool = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Title
                Text(snippet.title)
                    .font(.largeTitle)
                    .bold()
                    .padding(.horizontal)
                
                Text(snippet.summary ?? "")
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal)
                
                if snippet.demoViewTypeName != nil {
                    HStack(alignment: .center) {
                        Spacer()
                        NavigationLink {
                            demoCode()
                        } label: {
                            Text("Show Demo Code")
                        }
                        Spacer()
                    }
                }

                ForEach(Array(snippet.sections.enumerated()), id: \.offset) { index, sec in
                    Divider()
                    VStack(alignment: .leading, spacing: 12) {
                        Label(sec.sectionTitle, systemImage: "\(index + 1).circle.fill")
                            .font(.title2)
                            .bold()
                            .padding(.horizontal)
                        
                        Text(sec.description)
                            .padding(.horizontal)
                        
                        if let codeBlock = sec.codeBlock {
                            SnippetCodeBlockView(code: codeBlock)
                        }
                        
                    }
                    
                }

                
                
            
                

                
                Spacer(minLength: 40)
            }
            .padding(.vertical)
        }
        .navigationTitle(snippet.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
