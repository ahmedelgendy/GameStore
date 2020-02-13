//
//  DetailsViewModel.swift
//  GamesApp
//
//  Created by Elgendy on 13.02.2020.
//  Copyright © 2020 Elgendy. All rights reserved.
//

import Foundation

protocol DetailsViewModelDelegate: class {
    func onFavorited()
    func onFetchCompleted()
    func onFetchFailed(reason: String)
}

class DetailsViewModel {
    
    weak var delegate: DetailsViewModelDelegate?
    
    private var repository: FavoriteRepositoryProtocol
    private var game: GameDetails!
    private var service: GamesServiceProtocol
    private var gameId: Int!
    
    init(gameId: Int, service: GamesServiceProtocol, favoriteRepository: FavoriteRepositoryProtocol) {
        self.repository = favoriteRepository
        self.service = service
        self.gameId = gameId
    }
    
    var name: String? {
        game?.name
    }
    
    var imageURL: URL? {
        URL(string: game?.backgroundImage ?? "")
    }
    
    var description: String? {
        game?.description
    }
    
    var isFavorited: Bool {
        repository.isItemFavorited(id: game.storageId)
    }
    
    var favoriteButtonTitle: String {
        return isFavorited ? "Unfavorite" : "Favorite"
    }
    
    var redditURL: URL? {
        URL(string: game?.redditURL ?? "")
    }
    
    var websiteURL: URL? {
        URL(string: game?.website ?? "")
    }
    
    func favorite() {
        if repository.isItemFavorited(id: game.storageId) {
            repository.removeItem(game)
        } else {
            repository.addGame(game)
        }
        DispatchQueue.main.async {
            self.delegate?.onFavorited()
        }
    }
    
    func fetchDetails() {
        service.getGameDetails(id: gameId) { (result) in
            switch result {
            case .success(let value):
                DispatchQueue.main.async {
                    self.game = value
                    self.delegate?.onFetchCompleted()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.delegate?.onFetchFailed(reason: error.localizedDescription)
                }
            }
        }
    }
    
}
