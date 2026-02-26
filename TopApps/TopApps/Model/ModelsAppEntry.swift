//
//  AppEntry.swift
//  TopApps
//
//  Created by Nader Alfares on 2/22/26.
//

import Foundation

// MARK: - Root Response
struct AppFeedResponse: Codable {
    let feed: AppFeed
}

// MARK: - Feed
struct AppFeed: Codable {
    let entry: [AppEntry]
}

// MARK: - App Entry
struct AppEntry: Codable, Identifiable {
    let id: EntryID
    let name: EntryName
    let images: [EntryImage]
    let summary: EntryContent
    let price: EntryPrice
    let category: EntryCategory
    let artist: EntryArtist
    let releaseDate: EntryReleaseDate
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "im:name"
        case images = "im:image"
        case summary
        case price = "im:price"
        case category
        case artist = "im:artist"
        case releaseDate = "im:releaseDate"
    }
    
    var iconURL: URL? {
        guard let largestImage = images.max(by: { $0.height < $1.height }) else {
            return nil
        }
        return URL(string: largestImage.label)
    }
    
    var appName: String {
        name.label
    }
    
    var artistName: String {
        artist.label
    }
    
    var appSummary: String {
        summary.label
    }
    
    var priceDisplay: String {
        price.label
    }
    
    var categoryName: String {
        category.attributes.label
    }
}

// MARK: - Supporting Structures
struct EntryID: Codable, Hashable {
    let label: String
    let attributes: IDAttributes
}

struct IDAttributes: Codable, Hashable {
    let bundleId: String
    
    enum CodingKeys: String, CodingKey {
        case bundleId = "im:bundleId"
    }
}

struct EntryName: Codable {
    let label: String
}

struct EntryImage: Codable {
    let label: String
    let attributes: ImageAttributes
    
    var height: Int {
        Int(attributes.height) ?? 0
    }
}

struct ImageAttributes: Codable {
    let height: String
}

struct EntryContent: Codable {
    let label: String
}

struct EntryPrice: Codable {
    let label: String
    let attributes: PriceAttributes
}

struct PriceAttributes: Codable {
    let amount: String
    let currency: String
}

struct EntryCategory: Codable {
    let attributes: CategoryAttributes
}

struct CategoryAttributes: Codable {
    let label: String
    
    enum CodingKeys: String, CodingKey {
        case label
    }
}

struct EntryArtist: Codable {
    let label: String
}

struct EntryReleaseDate: Codable {
    let label: String
}
