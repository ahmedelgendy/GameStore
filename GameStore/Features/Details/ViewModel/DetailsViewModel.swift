//
//  DetailsViewModel.swift
//  GameStore
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
    private var favoriteRepository: FavoriteRepositoryProtocol
    private var seenItemsRepository: SeenItemsRepositoryProtocol
    private var game: GameDetails!
    private var repository: GameRepository
    private var gameId: Int!
    
    init(gameId: Int, repository: GameRepository,
         favoriteRepository: FavoriteRepositoryProtocol,
         seenItemsRepository: SeenItemsRepositoryProtocol) {
        self.favoriteRepository = favoriteRepository
        self.seenItemsRepository = seenItemsRepository
        self.repository = repository
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
        favoriteRepository.isItemFavorited(id: game.storageId)
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
        if favoriteRepository.isItemFavorited(id: game.storageId) {
            favoriteRepository.removeItem(game)
        } else {
            favoriteRepository.addGame(game)
        }
        DispatchQueue.main.async {
            self.delegate?.onFavorited()
        }
    }
    
    func fetchDetails() {
        repository.getGameDetails(id: gameId) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let value):
                    self.game = value
                    self.seenItemsRepository.markItemAsSeen(id: self.gameId)
                    self.delegate?.onFetchCompleted()
                case .failure(let error):
                    self.delegate?.onFetchFailed(reason: error.localizedDescription)
                }
            }
        }
    }
    
}
