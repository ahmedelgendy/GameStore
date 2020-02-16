//
//  SeenItemsRepository.swift
//  GameStore
//
//  Created by Elgendy on 14.02.2020.
//  Copyright © 2020 Elgendy. All rights reserved.
//

import Foundation

protocol SeenItemsRepositoryProtocol {
    func markItemAsSeen(id: Int)
    func isItemSeen(id: Int) -> Bool 
}

// MARK: - Seen Items
class SeenItemsRepository: SeenItemsRepositoryProtocol {
    
    private var storage: Storage
    
    init(storage: Storage) {
        self.storage = storage
    }
    
    private var seenItems: [Int] {
        get {
            storage.value(for: CacheKeys.seenItems) ?? []
        } set {
            storage.add(value: newValue, forKey: CacheKeys.seenItems)
        }
    }
    
    func markItemAsSeen(id: Int){
        if !isItemSeen(id: id) {
            seenItems.append(id)
            fireObserver()
        }
    }
    
    func isItemSeen(id: Int) -> Bool {
        seenItems.contains(id)
    }
    
    private func fireObserver() {
        NotificationCenter.default.post(name: .seenItemsUpdated,
                                        object: nil)
    }
    
}

