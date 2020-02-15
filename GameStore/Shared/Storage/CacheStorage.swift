//
//  CacheStorage.swift
//  GameStore
//
//  Created by Elgendy on 12.02.2020.
//  Copyright © 2020 Elgendy. All rights reserved.
//

import Foundation

class CacheStorage {
    
    static func add<T: Codable>(value: T, forKey key: String) {
        do {
            let data = try JSONEncoder().encode(value)
            UserDefaults.standard.set(data, forKey: key)
        } catch { }
    }
    
    static func get<T: Codable>(for key: String) -> T? {
        do {
            if let data = UserDefaults.standard.value(forKey: key) as? Data {
                return try JSONDecoder().decode(T.self, from: data)
            }
        } catch { }
        return nil
    }
    
    static func remove(key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
}

