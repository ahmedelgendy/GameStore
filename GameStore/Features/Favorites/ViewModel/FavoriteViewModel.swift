//
//  FavoriteViewModel.swift
//  GameStore
//
//  Created by Elgendy on 12.02.2020.
//  Copyright © 2020 Elgendy. All rights reserved.
//

import Foundation

protocol FavoriteViewModelDelegate: class {
    func onFetchCompleted(isEmpty: Bool)
}

class FavoriteViewModel {
    
    weak var delegate: FavoriteViewModelDelegate?
    private var games = [GameDetails]()
        
    private var repository: FavoriteRepositoryProtocol
    
    init(repository: FavoriteRepositoryProtocol) {
        self.repository = repository
    }
    
    func getFavoritedItems(){
        games = repository.getItems()
        delegate?.onFetchCompleted(isEmpty: games.count == 0 ? true : false )
    }
    
    func numberOfItems() -> Int {
        return self.games.count
    }
    
    func cellViewModelAt(index: Int) -> FavoriteCellViewModel {
        return FavoriteCellViewModel(game: self.games[index], repository: repository)
    }
    
    func gameIdAt(index: Int) -> Int {
        self.games[index].id
    }
}
