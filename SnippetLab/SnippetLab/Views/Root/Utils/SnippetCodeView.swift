//
//  SnippetCodeView.swift
//  SnippetLab
//
//  Created by Nader Alfares on 2/4/26.
//
import SwiftUI


///ref: https://medium.com/@orhanerday/building-a-swiftui-code-block-view-with-syntax-highlighting-d3d737a90a65
struct SnippetCodeBlockView: View {
    var code: String
    
    var body: some View {
        ScrollView(.horizontal) {
            Text(attributedString(for: code))
                .font(.system(.body, design: .monospaced))
                .multilineTextAlignment(.leading)
                .padding()
        }
        .background(Color.black)
        .foregroundStyle(.white)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray, lineWidth: 1)
        )
        .shadow(radius: 2)
        .padding(.horizontal)
    }
    // Helper function to create an AttributedString with simulated syntax highlighting
    func attributedString(for code: String) -> AttributedString {
        var attributedString = AttributedString(code)
        // Add syntax highlighting for Swift keywords, strings, etc.
        let keywords = ["let", "var", "if", "else", "struct", "func", "return"]
        let stringPattern = "\".*?\"" // Pattern to match strings
        let datatypes = [
            // Basic Swift types
            "Int", "Int8", "Int16", "Int32", "Int64",
            "UInt", "UInt8", "UInt16", "UInt32", "UInt64",
            "Float", "Double", "Bool", "String", "Character",
            "Void", "Any", "AnyObject",
            // Common Foundation types
            "Data", "Date", "URL", "UUID", "Decimal",
            // Common SwiftUI types
            "Color", "Image", "Text", "View", "Shape",
            "Angle", "CGFloat", "CGPoint", "CGSize", "CGRect",
            // Common collection types
            "Array", "Dictionary", "Set", "Range",
            // Optional and Result
            "Optional", "Result"
        ]
        // Highlight keywords
        for keyword in keywords {
            let ranges = code.ranges(of: keyword)
            for range in ranges {
                if let attributedRange = Range(NSRange(range, in: code), in: attributedString) {
                    attributedString[attributedRange].foregroundColor = .blue // Swift keywords in blue
                }
            }
        }
        // Highlight strings (enclosed in quotation marks)
        if let regex = try? NSRegularExpression(pattern: stringPattern) {
            let matches = regex.matches(in: code, range: NSRange(code.startIndex..., in: code))
            for match in matches {
                if let stringRange = Range(match.range, in: code),
                   let attributedRange = Range(NSRange(stringRange, in: code), in: attributedString) {
                    attributedString[attributedRange].foregroundColor = .green // Strings in green
                }
            }
        }
        
        //Highlight datatypes
        for datatype in datatypes {
            // Use word boundaries to match only standalone datatypes, not within other words
            let pattern = "\\b\(datatype)\\b"
            if let regex = try? NSRegularExpression(pattern: pattern) {
                let matches = regex.matches(in: code, range: NSRange(code.startIndex..., in: code))
                for match in matches {
                    if let datatypeRange = Range(match.range, in: code),
                       let attributedRange = Range(NSRange(datatypeRange, in: code), in: attributedString) {
                        attributedString[attributedRange].foregroundColor = .purple // Datatypes in purple
                    }
                }
            }
        }
        return attributedString
    }
}
extension String {
    /// Helper to find all ranges of a substring within a string
    func ranges(of substring: String) -> [Range<String.Index>] {
        var result: [Range<String.Index>] = []
        var startIndex = self.startIndex
        while startIndex < self.endIndex,
              let range = self.range(of: substring, range: startIndex..<self.endIndex) {
            result.append(range)
            startIndex = range.upperBound
        }
        return result
    }
}


#Preview {
    VStack(spacing: 20) {
        
        SnippetCodeBlockView(code: """
            func greet(name: String) -> String {
                let message = "Hello, \\(name)!"
                return message
            }
            """)
        
        SnippetCodeBlockView(code: """
            struct Person {
                var name: String
                var age: Int
                
                func introduce() {
                    let greeting = "Hi, I'm \\(name)"
                    if age >= 18 {
                        return greeting
                    } else {
                        return "I'm a minor"
                    }
                }
            }
            """)
        
        Spacer()
    }
}

