//
//  LocalStorage.swift
//  GamesApp
//
//  Created by Elgendy on 12.02.2020.
//  Copyright © 2020 Elgendy. All rights reserved.
//

import Foundation

class LocalStorage {
    
    static func add(value: Any, forKey key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    static func getValue(for key: String) -> Any? {
        UserDefaults.standard.value(forKey: key)
    }
    
    static func remove(key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
}
