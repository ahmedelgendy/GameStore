//
//  SearchCellViewModel.swift
//  GameStore
//
//  Created by Elgendy on 12.02.2020.
//  Copyright © 2020 Elgendy. All rights reserved.
//

import Foundation

struct SearchCellViewModel {
    
    private var game: Game
    private var repository: GameRepositoryProtocol
    
    init(game: Game, repository: GameRepositoryProtocol) {
        self.game = game
        self.repository = repository
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
    
    var isGameSeen: Bool {
        return repository.isSeen(id: game.id)
    }
    
}
