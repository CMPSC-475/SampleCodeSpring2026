//
//  CircleCircularPosition.swift
//  SnippetLab
//
//  Created by Nader Alfares on 2/7/26.
//


fileprivate let snippetSections : [SnippetSection] = [
    SnippetSection (sectionTitle: "Define Parameters", description: "", codeBlock: """
                        let startAngle: Angle = .degrees(0)
                        let endAngle: Angle = .degrees(360)
                        
                        var deltaAngle: Angle {
                            .degrees((endAngle.degrees - startAngle.degrees) / Double(numberOfCircles))
                        }
                        """),
    SnippetSection(sectionTitle: "Calculate Angle Distribution", description: "We distribute the circles evenly around a full 360° circle by dividing the total angle by the number of circles. For 6 circles: 360° ÷ 6 = 60° between each circle"),
    SnippetSection(sectionTitle: "Create Each Circle", description: "Use ForEach to create each circle and calculate its specific angle.", codeBlock: """
                        ForEach(0..<numberOfCircles, id: \\.self) { index in
                            let angle = startAngle + deltaAngle * Double(index)
                            // ...
                        }
                        """),
    SnippetSection(sectionTitle: "Calculate X & Y Positions", description: "Use trigonometry to convert polar coordinates (angle and radius) to Cartesian coordinates (x and y). cos(angle) gives the horizontal offset, and sin(angle) gives the vertical offset.", codeBlock: """
                        let xOffset = cos(angle.radians) * radius
                        let yOffset = sin(angle.radians) * radius
                        """),
    SnippetSection(sectionTitle: "Position the Circle", description: "Use the calculated x and y offsets to position each circle at its correct location around the center.", codeBlock: """
                        Circle()
                            .fill(Color.random)
                            .frame(width: 100, height: 100)
                            .opacity(0.5)
                            .offset(x: xOffset, y: yOffset)
                        """)
    
    
]

let circlePostionSnippet = Snippet(
    title: "Circle Placement Demo",
    summary: "This demo shows how to arrange circles in a circular pattern using trigonometry.",
    sections: snippetSections,
    demoViewTypeName: "CirclePositionDemo"
)




