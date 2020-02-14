//
//  FavoriteRepository.swift
//  GamesApp
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
        fireObserver()
    }
    
    func removeItem(_ game: GameDetails) {
        gamesIds = gamesIds.filter { $0 != game.storageId }
        LocalStorage.remove(key: game.storageId)
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
