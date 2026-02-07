//
//  NavigationStack.swift
//  SnippetLab
//
//  Created by Nader Alfares on 2/7/26.
//

fileprivate let snippetSections : [SnippetSection] = [
    SnippetSection(sectionTitle: "Basic NavigationStack", description: "NavigationStack is the Swift/SwiftUI way to handle navigation. Ensure that the NavigationStack is created at the top-level view in your app.", codeBlock: """
                        NavigationStack {
                            NavigationLink("Simple Detail View") {
                                SampleDetailView()
                            }
                        }
                        """),
    SnippetSection(sectionTitle: "Programmatic Navigation", description: "Use a NavigationPath to control navigation programmatically. This allows you to push views onto the stack from anywhere in your code. The path is wrapped with a @State to allow the view to update dynamically.", codeBlock: """
                        @State private var path = NavigationPath()
                        """),
    SnippetSection(sectionTitle: "Type-Safe Navigation", description: "Use custom types with NavigationPath for type-safe navigation. This ensures you're navigating to the correct destination.", codeBlock: """
                        enum Destination: Hashable {
                            case detail(id: Int)
                            case settings
                            case profile(name: String)
                        }
                        
                        NavigationStack(path: $path) {
                            // content of your stack view
                            // ...
                            .navigationTitle("Navigation Stack")
                            .navigationDestination(for: Destination.self) { destination in
                                switch destination {
                                case .detail(let id):
                                    DetailViewWithID(id: id, path: $path)
                                case .settings:
                                    SettingsView(path: $path)
                                case .profile(let name):
                                    ProfileView(name: name)
                                }
                            }
                        }
                        """),
    SnippetSection(sectionTitle: "Deep Linking", description: "The path variable can be set to represent the different levels of a deep link. For example, Settings -> Profile.", codeBlock: """
                        struct SettingsView: View {
                            @Binding var path : NavigationPath
                            var body: some View {
                                Form {
                                    Section("General") {
                                        Button("Go to Profile") {
                                            path.append(NavigationStackDemo.Destination.profile(name: "Jane Doe"))
                                        }
                                    }
                                }
                                .navigationTitle("Settings")
                            }
                        }
                        """)
]

let navigationStackSnippet = Snippet(
    title: "NavigationStack",
    summary: "NavigationStack provides a declarative way to handle navigation in SwiftUI with support for programmatic navigation and deep linking. To demo the code, use the canvas preview in the demo code found in View->Topics. The demo code is wrapped with a Form View for better presentation, where each section is focuses on a different aspect of the NavigationStack.",
    sections: snippetSections,
    demoViewTypeName: nil
)
