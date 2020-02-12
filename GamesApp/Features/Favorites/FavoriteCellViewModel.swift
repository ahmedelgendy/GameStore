//
//  FavoriteCellViewModel.swift
//  GamesApp
//
//  Created by Elgendy on 12.02.2020.
//  Copyright © 2020 Elgendy. All rights reserved.
//

import Foundation

class FavoriteCellViewModel {
    
    private var storage: FavoriteRepositoryProtocol
    
    init(storage: FavoriteRepositoryProtocol) {
        self.storage = storage
    }
    
    func favoriteItem(id: Int) {
        storage.addItem(id: id)
    }
    
    func unfavoriteItem(id: Int) {
        storage.removeItem(id: id)
    }
}
