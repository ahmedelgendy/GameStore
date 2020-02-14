//
//  URLComponents+addQuery.swift
//  GamesApp
//
//  Created by Elgendy on 11.02.2020.
//  Copyright © 2020 Elgendy. All rights reserved.
//

import Foundation

extension URLComponents {
    mutating func addQuery(key: String, value: String) {
        if self.queryItems == nil {
            self.queryItems = [URLQueryItem]()
        }
        let param = URLQueryItem(name: key, value: value)
        self.queryItems?.append(param)
    }
}
