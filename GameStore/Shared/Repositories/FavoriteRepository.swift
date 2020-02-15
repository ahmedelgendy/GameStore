//
//  FavoriteRepository.swift
//  GameStore
//
//  Created by Elgendy on 11.02.2020.
//  Copyright © 2020 Elgendy. All rights reserved.
//

import Foundation

protocol FavoriteRepositoryProtocol {
    var gamesIds: [String] { get }
    func addGame(_ game: GameDetails)
    func removeItem(_ game: GameDetails)
    func getItems() -> [GameDetails]
    func isItemFavorited(id: String) -> Bool
}

final class FavoriteRepository: FavoriteRepositoryProtocol {
        
    var gamesIds: [String] {
        get {
            CacheStorage.get(for: CacheKeys.favoritedItems) ?? []
        } set {
            CacheStorage.add(value: newValue, forKey: CacheKeys.favoritedItems)
        }
    }
    
    func getItems() -> [GameDetails] {
        var games = [GameDetails]()
        gamesIds.forEach { (gameId) in
            if let gameJson: GameDetails = CacheStorage.get(for: gameId) {
                games.append(gameJson)
            }
        }
        return games
    }
    
    func addGame(_ game: GameDetails) {
        CacheStorage.add(value: game, forKey: game.storageId)
        if !gamesIds.contains(game.storageId) {
            gamesIds.append(game.storageId)
        }
        fireObserver()
    }
    
    func removeItem(_ game: GameDetails) {
        gamesIds = gamesIds.filter { $0 != game.storageId }
        CacheStorage.remove(key: game.storageId)
        fireObserver()
    }
    
    func isItemFavorited(id: String) -> Bool {
        return gamesIds.contains(id)
    }
    
    private func fireObserver() {
        NotificationCenter.default.post(name: .favoritedItemsUpdated,
                                        object: nil)
    }
}
