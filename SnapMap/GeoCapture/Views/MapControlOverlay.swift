//
//  MapControlOverlay.swift
//  GeoCapture
//
//  Created by Nader Alfares on 3/25/26.
//
import SwiftUI
import MapKit


struct MapControlOverlay: View {
    @Environment(MapManager.self) var manager
    
    var body: some View {
        @Bindable var manager = manager
        ZStack {
            Spacer(minLength: 0)
            VStack(spacing: 12) {
                // Hint pill
                Text("Tap on the map to add a location")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 8)
                    .background(.ultraThinMaterial, in: Capsule())
                    .overlay(
                        Capsule().strokeBorder(.separator.opacity(0.3))
                    )

                // Floating control bar
                HStack(spacing: 16) {
                    // Map type toggle
                    Button(action: {
                        manager.mapType = nextMapType(from: manager.mapType, in: manager.availableMapTypes)
                    }) {
                        HStack(spacing: 8) {
                            Image(systemName: "map")
                                .font(.system(size: 17, weight: .semibold))
                            Text(mapTypeName(manager.mapType))
                                .font(.callout.weight(.semibold))
                        }
                        .frame(width: 150)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 14)
                        .background(.thinMaterial, in: Capsule())
                    }
                    
                    .buttonStyle(.plain)
                    .contentShape(Rectangle())

                    // Pins count display
                    HStack(spacing: 6) {
                        Image(systemName: "mappin.and.ellipse")
                            .font(.system(size: 17, weight: .semibold))
                        Text("\(manager.locationPins.count)")
                            .font(.callout.weight(.semibold))
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 14)
                    .background(.thinMaterial, in: Capsule())
                    .accessibilityElement(children: .combine)
                }
                .padding(10)
                .background(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(.ultraThinMaterial)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .stroke(.separator.opacity(0.2))
                )
                .shadow(color: .black.opacity(0.15), radius: 20, x: 0, y: 10)
                .padding(.horizontal)
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, 24)
            .ignoresSafeArea(edges: .bottom)
            .frame(maxHeight: .infinity, alignment: .bottom)
        }
    }
    
    private func nextMapType(from current: MKMapType, in options: [MKMapType]) -> MKMapType {
        guard let idx = options.firstIndex(of: current) else { return current }
        let next = options.index(after: idx)
        return next < options.endIndex ? options[next] : options.first ?? current
    }
    
    private func mapTypeName(_ type: MKMapType) -> String {
        switch type {
        case .standard:
            return "Standard"
        case .hybrid:
            return "Hybrid"
        case .satellite:
            return "Satellite"
        default:
            return "Standard"
        }
    }
}

