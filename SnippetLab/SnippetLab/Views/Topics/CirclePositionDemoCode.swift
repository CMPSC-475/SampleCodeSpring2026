//
//  PlacementDemoCode.swift
//  SnippetLab
//
//  Created by Nader Alfares on 2/4/26.
//
import SwiftUI

struct CirclePositionDemo: View, DemoView  {
    var numberOfCircles: Int = 6
    var radius: CGFloat = 50   // <— control how far from the center
    
    let startAngle: Angle = .degrees(0)
    let endAngle : Angle = .degrees(360)
    private var deltaAngle: Angle {
        .degrees((endAngle.degrees - startAngle.degrees) / Double(numberOfCircles))
    }
    
    var body: some View {
        ZStack {
            ForEach(0..<numberOfCircles, id: \.self) { index in
                let angle = startAngle + deltaAngle * Double(index)
                let xOffset = cos(angle.radians) * radius
                let yOffset = sin(angle.radians) * radius
                
                Circle()
                    
                    .fill(Color.random)
                    .frame(width: 100, height: 100)
                    .opacity(0.5)
                    .offset(x: xOffset, y: yOffset)
            }
        }
    }
}

#Preview {
    CirclePositionDemo()
}
