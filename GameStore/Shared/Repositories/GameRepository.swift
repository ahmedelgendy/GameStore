//
//  GameRepository.swift
//  GameStore
//
//  Created by Elgendy on 14.02.2020.
//  Copyright © 2020 Elgendy. All rights reserved.
//

import Foundation

protocol GameRepositoryProtocol {
    func searchGames(with params: SearchGamesParameters, completion: @escaping SearchGamesCallBack)
    func getGameDetails(id: Int, completion: @escaping GameDetailsCallBack)
    // favorite
    func getFavoritedGames() -> [GameDetails]
    func setFavorite(_ game: GameDetails)
    func setUnfavorite(_ game: GameDetails)
    func isFavorited(id: String) -> Bool
    // seen
    func setSeen(id: Int)
    func isSeen(id: Int) -> Bool
}

class GameRepository: GameRepositoryProtocol {
    
    private var service: GamesServiceProtocol!
    private var storage: Storage
    
    init(service: GamesServiceProtocol, storage: Storage) {
        self.service = service
        self.storage = storage
    }

    // MARK: - fetch games
    func searchGames(with params: SearchGamesParameters, completion: @escaping SearchGamesCallBack) {
        let url = GamesEndpoint.searchGames(params: params).urlRequest.url?.absoluteString
        if let data: SearchGamesResponse = storage.value(for: url!) {
            completion(.success(data))
        } else {
            service.searchGames(params: params) { result in
                switch result {
                case .success(let value):
                    guard let key = self.service.network.urlRequest.url?.absoluteString else {
                        fatalError()
                    }
                    self.storage.add(value: value , forKey: key)
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
                
            }
        }
    }
    
    // MARK: - Game Details
    func getGameDetails(id: Int, completion: @escaping GameDetailsCallBack) {
        service.getGameDetails(id: id, completion)
    }

}

// MARK: - Favorite Items

extension GameRepository {
    private var gamesIds: [String] {
        get {
            storage.value(for: CacheKeys.favoritedItems) ?? []
        } set {
            storage.add(value: newValue, forKey: CacheKeys.favoritedItems)
        }
    }
    
    func getFavoritedGames() -> [GameDetails] {
        var games = [GameDetails]()
        gamesIds.forEach { (gameId) in
            if let gameJson: GameDetails = storage.value(for: gameId) {
                games.append(gameJson)
            }
        }
        return games
    }
    
    func setFavorite(_ game: GameDetails) {
        storage.add(value: game, forKey: game.storageId)
        if !gamesIds.contains(game.storageId) {
            gamesIds.append(game.storageId)
        }
        notifyFavoritedItemsUpdated()
    }
    
    func setUnfavorite(_ game: GameDetails) {
        gamesIds = gamesIds.filter { $0 != game.storageId }
        storage.remove(key: game.storageId)
        notifyFavoritedItemsUpdated()
    }
    
    func isFavorited(id: String) -> Bool {
        return gamesIds.contains(id)
    }
    
    private func notifyFavoritedItemsUpdated() {
        NotificationCenter.default.post(name: .favoritedItemsUpdated,
                                        object: nil)
    }
}

// MARK: - Seen Items

extension GameRepository {
    private var seenItems: [Int] {
        get {
            storage.value(for: CacheKeys.seenItems) ?? []
        } set {
            storage.add(value: newValue, forKey: CacheKeys.seenItems)
        }
    }
    
    func setSeen(id: Int) {
        if !isSeen(id: id) {
            seenItems.append(id)
            notifySeenItemsUpdated()
        }
    }
    
    func isSeen(id: Int) -> Bool {
        seenItems.contains(id)
    }
    
    private func notifySeenItemsUpdated() {
        NotificationCenter.default.post(name: .seenItemsUpdated,
                                        object: nil)
    }
}
