//
//  DashboardSections.swift
//  WristDash
//
//  Created by Nader Alfares on 4/1/26.
//
import SwiftUI

struct NumberSliderSection : View {
    @Environment(DashboardManager.self) var dashboardManager : DashboardManager
    let optionsRange : ClosedRange<Double> = 0...100
    var body : some View {
        @Bindable var dsMngr = self.dashboardManager
        Section("Number") {
            HStack {
                Slider(value: $dsMngr.selectedNumber, in: optionsRange, step: 1)
                Text("\(Int(dsMngr.selectedNumber))")
                    .monospacedDigit()
                    .frame(width: 40)
            }
        }
    }
}


struct ColorGridPicker : View {
    @Environment(DashboardManager.self) var dashboardManager : DashboardManager
    var body : some View {
        let colorOptions = dashboardManager.colorOptions
        @Bindable var dsMngr = self.dashboardManager
        Section("Color") {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 12) {
                ForEach(colorOptions, id: \.self) { color in
                    Circle()
                        .fill(color)
                        .frame(width: 44, height: 44)
                        .overlay(
                            Circle()
                                .stroke(.primary, lineWidth: dsMngr.selectedColor == color ? 3 : 0)
                        )
                        .onTapGesture {
                            dsMngr.selectedColor = color
                        }
                }
            }
            .padding(.vertical, 4)
        }
    }
}

struct IconGridPicker : View {
    @Environment(DashboardManager.self) var dashboardManager : DashboardManager
    var body : some View {
        let iconOptions = dashboardManager.iconOptions
        @Bindable var dsMngr = dashboardManager
        Section("Icon") {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 12) {
                ForEach(iconOptions, id: \.self) { icon in
                    Image(systemName: icon)
                        .font(.title2)
                        .frame(width: 44, height: 44)
                        .background(dsMngr.selectedIcon == icon ? Color.accentColor.opacity(0.2) : Color.clear)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .onTapGesture {
                            dsMngr.selectedIcon = icon
                        }
                }
            }
            .padding(.vertical, 4)
        }
    }
}

struct MessageFeild : View {
    @Environment(DashboardManager.self) var dashboardManager : DashboardManager
    var body : some View {
        @Bindable var dsMngr = dashboardManager
        Section("Message") {
            TextField("Enter a message", text: $dsMngr.message)
        }
    }
}


