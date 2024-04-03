//
//  CoinDetail.swift
//  CrytpoTracker
//
//  Created by Abhijith on 27/03/24.
//

import Foundation

// MARK: - CoinDetail
struct CoinDetail: Codable {
    let id, symbol, name, webSlug: String?
    let blockTimeInMinutes: Int?
    let hashingAlgorithm: String?
    let categories: [String]?
    let previewListing: Bool?
    let description: Description?
    let links: Links?

    enum CodingKeys: String, CodingKey {
        case id, symbol, name
        case webSlug = "web_slug"
        case blockTimeInMinutes = "block_time_in_minutes"
        case hashingAlgorithm = "hashing_algorithm"
        case categories
        case previewListing = "preview_listing"
        case description, links
    }
}

// MARK: - Description
struct Description: Codable {
    let en: String?
}
// MARK: - Links
struct Links: Codable {
    let homepage: [String]?
    let subredditURL: String?

    enum CodingKeys: String, CodingKey {
        case homepage
        case subredditURL = "subreddit_url"
    }
}

