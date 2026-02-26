//
//  AppRowView.swift
//  TopApps
//
//  Created by Nader Alfares on 2/22/26.
//

import SwiftUI

struct AppRowView: View {
    let app: AppEntry
    let rank: Int
    
    var body: some View {
        HStack(spacing: 16) {
            // Rank Badge
            Text("\(rank)")
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundStyle(.secondary)
                .frame(width: 40, alignment: .leading)
            
            // App Icon
            AsyncImage(url: app.iconURL) { phase in
                switch phase {
                case .empty:
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.gray.opacity(0.2))
                        .overlay {
                            ProgressView()
                        }
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                case .failure:
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.gray.opacity(0.2))
                        .overlay {
                            Image(systemName: "app.badge")
                                .foregroundStyle(.secondary)
                        }
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: 60, height: 60)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 2)
            
            // App Info
            VStack(alignment: .leading, spacing: 4) {
                Text(app.appName)
                    .font(.system(size: 16, weight: .semibold))
                    .lineLimit(1)
                
                Text(app.artistName)
                    .font(.system(size: 14))
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
                
                HStack(spacing: 6) {
                    Text(app.categoryName)
                        .font(.system(size: 12))
                        .foregroundStyle(.secondary)
                    
                    Circle()
                        .fill(Color.secondary)
                        .frame(width: 3, height: 3)
                    
                    Text(app.priceDisplay)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(.blue)
                }
            }
            
            Spacer(minLength: 0)
            
            // Chevron
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(.tertiary)
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    AppRowView(
        app: AppEntry(
            id: EntryID(label: "1", attributes: IDAttributes(bundleId: "com.test.app")),
            name: EntryName(label: "Test App"),
            images: [
                EntryImage(
                    label: "https://is1-ssl.mzstatic.com/image/thumb/Purple221/v4/test.png",
                    attributes: ImageAttributes(height: "60")
                )
            ],
            summary: EntryContent(label: "This is a test app"),
            price: EntryPrice(
                label: "$4.99",
                attributes: PriceAttributes(amount: "4.99", currency: "USD")
            ),
            category: EntryCategory(
                attributes: CategoryAttributes(label: "Games")
            ),
            artist: EntryArtist(label: "Test Developer"),
            releaseDate: EntryReleaseDate(label: "2024-01-01T00:00:00-07:00")
        ),
        rank: 1
    )
    .padding()
}
