//
//  SeenItemsRepository.swift
//  GameStore
//
//  Created by Elgendy on 14.02.2020.
//  Copyright © 2020 Elgendy. All rights reserved.
//

import Foundation

// MARK: - Seen Items
class SeenItemsRepository {
    
    private static var seenItems: [Int] {
        get {
            LocalStorage.getValue(for: "seenItems") as? [Int] ?? []
        } set {
            LocalStorage.add(value: newValue, forKey: "seenItems")
        }
    }
    
    static func markItemAsSeen(id: Int){
        if !isItemSeen(id: id) {
            seenItems.append(id)
            fireObserver()
        }
    }
    
    static func isItemSeen(id: Int) -> Bool {
        seenItems.contains(id)
    }
    
    private static func fireObserver() {
        NotificationCenter.default.post(name: .seenItemsUpdated,
                                        object: nil)
    }
    
}

