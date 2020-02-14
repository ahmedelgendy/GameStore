//
//  FavoriteCellViewModel.swift
//  GameStore
//
//  Created by Elgendy on 12.02.2020.
//  Copyright © 2020 Elgendy. All rights reserved.
//

import Foundation

class FavoriteCellViewModel {
    
    private var repository: FavoriteRepositoryProtocol
    private var game: GameDetails
    
    init(game: GameDetails, repository: FavoriteRepositoryProtocol) {
        self.repository = repository
        self.game = game
    }
    
    var name: String? { game.name }
    
    var metacritic: String? {
        if let metacritic = game.metacritic {
            return "\(metacritic)"
        } else {
            return nil
        }
    }
    
    var imageURL: URL? {
        return URL(string: game.backgroundImage ?? "")
    }
    
    var genres: String? {
        return game.genres.map({ $0.name }).joined(separator: ", ")
    }
    
    
}
