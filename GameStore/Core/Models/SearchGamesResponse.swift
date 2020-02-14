//
//  SearchGamesResponse.swift
//  GameStore
//
//  Created by Elgendy on 11.02.2020.
//  Copyright © 2020 Elgendy. All rights reserved.
//

import Foundation

// MARK: - SearchGamesResponse
struct SearchGamesResponse: Codable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [Game]?
    let userPlatforms: Bool?

    enum CodingKeys: String, CodingKey {
        case count, next, previous, results
        case userPlatforms = "user_platforms"
    }
}

// MARK: - Game
struct Game: Codable {
    let slug, name: String?
    let playtime: Int?
    let platforms: [Platform]?
    let stores: [Store]?
    let released: String?
    let tba: Bool?
    let backgroundImage: String?
    let rating: Double?
    let ratingTop: Int?
    let ratings: [Rating]?
    let ratingsCount, reviewsTextCount, added: Int?
    let addedByStatus: AddedByStatus?
    let metacritic: Int?
    let suggestionsCount: Int?
    let id: Int
    let score: String?
    let clip: Clip?
    let tags: [Tag]
    let userGame: String?
    let reviewsCount: Int?
    let saturatedColor, dominantColor: String?
    let shortScreenshots: [ShortScreenshot]?
    let parentPlatforms: [ParentPlatform]?
    let genres: [Genre]
    let communityRating: Int?

    enum CodingKeys: String, CodingKey {
        case slug, name, playtime, platforms, stores, released, tba
        case backgroundImage = "background_image"
        case rating
        case ratingTop = "rating_top"
        case ratings
        case ratingsCount = "ratings_count"
        case reviewsTextCount = "reviews_text_count"
        case added
        case addedByStatus = "added_by_status"
        case metacritic
        case suggestionsCount = "suggestions_count"
        case id, score, clip, tags
        case userGame = "user_game"
        case reviewsCount = "reviews_count"
        case saturatedColor = "saturated_color"
        case dominantColor = "dominant_color"
        case shortScreenshots = "short_screenshots"
        case parentPlatforms = "parent_platforms"
        case genres
        case communityRating = "community_rating"
    }
}

// MARK: - AddedByStatus
struct AddedByStatus: Codable {
    let yet, owned, beaten, toplay: Int?
    let dropped, playing: Int?
}

// MARK: - Clip
struct Clip: Codable {
    let clip: String?
    let clips: Clips?
    let video: String?
    let preview: String?
}

// MARK: - Clips
struct Clips: Codable {
    let the320, the640, full: String?

    enum CodingKeys: String, CodingKey {
        case the320 = "320"
        case the640 = "640"
        case full
    }
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
    let slug: String?
    let gamesCount: Int?
    let imageBackground: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case slug = "slug"
        case gamesCount = "games_count"
        case imageBackground = "image_background"
    }
}

// MARK: - Platform
struct ParentPlatform: Codable {
    let platform: Genre?
}

// MARK: - Rating
struct Rating: Codable {
    let id: Int?
    let title: String?
    let count: Int?
    let percent: Double?
}

// MARK: - ShortScreenshot
struct ShortScreenshot: Codable {
    let id: Int?
    let image: String?
}

// MARK: - Store
struct Store: Codable {
    let store: Genre?
}

// MARK: - Tag
struct Tag: Codable {
    let id: Int?
    let name, slug: String?
    let language: String?
    let gamesCount: Int?
    let imageBackground: String?

    enum CodingKeys: String, CodingKey {
        case id, name, slug, language
        case gamesCount = "games_count"
        case imageBackground = "image_background"
    }
}
