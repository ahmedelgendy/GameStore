//
//  FavoriteRepository.swift
//  GamesApp
//
//  Created by Elgendy on 11.02.2020.
//  Copyright © 2020 Elgendy. All rights reserved.
//

import Foundation

struct GameDetails: Codable {
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
    let parentPlatforms: [Platform]?
    let genres: [Genre]
    let communityRating: Int?

    var storageId: String {
        return "gameDetails+\(id)"
    }
}

protocol FavoriteRepositoryProtocol {
    var gamesIds: [String] { get }
    func addGame(_ game: GameDetails)
    func removeItem(_ game: GameDetails)
    func getItems() -> [GameDetails]
    func isItemFavorited(id: String) -> Bool
}

final class FavoriteRepository: FavoriteRepositoryProtocol {
    
    let favoritedKey = "favoritedItems"
    
    var gamesIds: [String] {
        get {
            LocalStorage.getValue(for: favoritedKey) as? [String] ?? []
        } set {
            LocalStorage.add(value: newValue, forKey: favoritedKey)
        }
    }
    
    func getItems() -> [GameDetails] {
        var games = [GameDetails]()
        gamesIds.forEach { (gameId) in
            if let gameJson = LocalStorage.getValue(for: gameId) as? Data {
                do {
                    let gameObject = try JSONDecoder().decode(GameDetails.self, from: gameJson)
                    games.append(gameObject)
                } catch { }
            }
        }
        return games
    }
    
    func addGame(_ game: GameDetails) {
        do {
            let gameJson = try JSONEncoder().encode(game)
            LocalStorage.add(value: gameJson, forKey: game.storageId)
        } catch { }
        if !gamesIds.contains(game.storageId) {
            gamesIds.append(game.storageId)
        }
    }
    
    func removeItem(_ game: GameDetails) {
        gamesIds = gamesIds.filter { $0 != game.storageId }
        LocalStorage.remove(key: game.storageId)
    }
    
    func isItemFavorited(id: String) -> Bool {
        return gamesIds.contains(id)
    }
}
