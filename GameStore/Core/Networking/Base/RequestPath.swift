//
//  RequestPath.swift
//  GameStore
//
//  Created by Elgendy on 11.02.2020.
//  Copyright © 2020 Elgendy. All rights reserved.
//

import Foundation

enum RequestPath {
    
    case games
    
    var path: String {
        switch self {
        case .games:
            return createPath("/games")
        }
    }
    
    private func createPath(_ path: String) -> String {
        return AppConstants.URL.apiPath + path
    }
}
