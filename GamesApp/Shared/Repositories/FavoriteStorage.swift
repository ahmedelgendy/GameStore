//
//  FavoriteRepository.swift
//  GamesApp
//
//  Created by Elgendy on 11.02.2020.
//  Copyright © 2020 Elgendy. All rights reserved.
//

import Foundation

protocol FavoriteRepositoryProtocol {
    var items: Set<Int> { get }
    func addItem(id: Int)
    func removeItem(id: Int)
    func isItemFavorited(id: Int) -> Bool
}

final class FavoriteRepository: FavoriteRepositoryProtocol {
    
    let userDefaultsKey = "favoritedItems"
    
    var items: Set<Int> {
        get {
            LocalStorage.getValue(for: userDefaultsKey) as? Set<Int> ?? []
        } set {
            LocalStorage.add(value: newValue, forKey: userDefaultsKey)
        }
    }
    
    func addItem(id: Int) {
        items.insert(id)
    }
    
    func removeItem(id: Int) {
        items.remove(id)
    }
    
    func isItemFavorited(id: Int) -> Bool {
        return items.contains(id)
    }
}
