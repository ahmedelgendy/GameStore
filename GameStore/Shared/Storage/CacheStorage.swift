//
//  CacheStorage.swift
//  GameStore
//
//  Created by Elgendy on 12.02.2020.
//  Copyright © 2020 Elgendy. All rights reserved.
//

import Foundation

protocol Storage {
    func add<T: Codable>(value: T, forKey key: String)
    func value<T: Codable>(for key: String) -> T?
    func remove(key: String)
}

class CacheStorage: Storage {
    
    func add<T: Codable>(value: T, forKey key: String) {
        do {
            let data = try JSONEncoder().encode(value)
            UserDefaults.standard.set(data, forKey: key)
        } catch { }
    }
    
    func value<T: Codable>(for key: String) -> T? {
        do {
            if let data = UserDefaults.standard.value(forKey: key) as? Data {
                return try JSONDecoder().decode(T.self, from: data)
            }
        } catch { }
        return nil
    }
    
    func remove(key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
}

