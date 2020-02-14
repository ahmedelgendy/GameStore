//
//  String+htmlStripped.swift
//  GamesApp
//
//  Created by Elgendy on 13.02.2020.
//  Copyright © 2020 Elgendy. All rights reserved.
//

import Foundation

extension String {
    var htmlStripped: String {
        let htmlStripped = replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        let extraSpacesStripped = htmlStripped.replacingOccurrences(of: "[\\s\n]+", with: " ", options: .regularExpression, range: nil)
        return extraSpacesStripped
    }
}
