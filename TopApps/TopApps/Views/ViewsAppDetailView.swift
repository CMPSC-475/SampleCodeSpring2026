//
//  AppDetailView.swift
//  TopApps
//
//  Created by Nader Alfares on 2/22/26.
//

import SwiftUI

struct AppDetailView: View {
    let app: AppEntry
    let rank: Int
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Header
                VStack(spacing: 16) {
                    AsyncImage(url: app.iconURL) { phase in
                        switch phase {
                        case .empty:
                            RoundedRectangle(cornerRadius: 24)
                                .fill(Color.gray.opacity(0.2))
                                .overlay {
                                    ProgressView()
                                }
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        case .failure:
                            RoundedRectangle(cornerRadius: 24)
                                .fill(Color.gray.opacity(0.2))
                                .overlay {
                                    Image(systemName: "app.badge")
                                        .font(.system(size: 40))
                                        .foregroundStyle(.secondary)
                                }
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .frame(width: 120, height: 120)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 5)
                    
                    VStack(spacing: 8) {
                        Text(app.appName)
                            .font(.system(size: 24, weight: .bold))
                            .multilineTextAlignment(.center)
                        
                        Text(app.artistName)
                            .font(.system(size: 16))
                            .foregroundStyle(.secondary)
                    }
                    
                    // Rank Badge
                    HStack(spacing: 12) {
                        VStack(spacing: 4) {
                            Text("#\(rank)")
                                .font(.system(size: 22, weight: .bold, design: .rounded))
                            Text("Ranking")
                                .font(.system(size: 12))
                                .foregroundStyle(.secondary)
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.blue.opacity(0.1))
                        )
                        
                        VStack(spacing: 4) {
                            Text(app.priceDisplay)
                                .font(.system(size: 22, weight: .bold, design: .rounded))
                                .foregroundStyle(.blue)
                            Text("Price")
                                .font(.system(size: 12))
                                .foregroundStyle(.secondary)
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.blue.opacity(0.1))
                        )
                    }
                }
                .padding(.top, 20)
                
                Divider()
                
                // Category
                VStack(alignment: .leading, spacing: 8) {
                    Label("Category", systemImage: "square.grid.2x2")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(.secondary)
                    
                    Text(app.categoryName)
                        .font(.system(size: 16))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                
                Divider()
                
                // Description
                VStack(alignment: .leading, spacing: 8) {
                    Label("About", systemImage: "text.alignleft")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(.secondary)
                    
                    Text(app.appSummary)
                        .font(.system(size: 16))
                        .lineSpacing(4)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                
                Spacer(minLength: 20)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("App Details")
                    .font(.system(size: 17, weight: .semibold))
            }
        }
    }
}

#Preview {
    NavigationStack {
        AppDetailView(
            app: AppEntry(
                id: EntryID(label: "1", attributes: IDAttributes(bundleId: "com.test.app")),
                name: EntryName(label: "Test App"),
                images: [
                    EntryImage(
                        label: "https://is1-ssl.mzstatic.com/image/thumb/Purple221/v4/test.png",
                        attributes: ImageAttributes(height: "120")
                    )
                ],
                summary: EntryContent(label: "This is a fantastic test app that does amazing things. It has been carefully crafted to provide the best user experience possible."),
                price: EntryPrice(
                    label: "$4.99",
                    attributes: PriceAttributes(amount: "4.99", currency: "USD")
                ),
                category: EntryCategory(
                    attributes: CategoryAttributes(label: "Games")
                ),
                artist: EntryArtist(label: "Test Developer Inc."),
                releaseDate: EntryReleaseDate(label: "2024-01-01T00:00:00-07:00")
            ),
            rank: 1
        )
    }
}
