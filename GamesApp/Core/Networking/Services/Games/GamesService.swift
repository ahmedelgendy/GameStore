//
//  GamesService.swift
//  GamesApp
//
//  Created by Elgendy on 11.02.2020.
//  Copyright © 2020 Elgendy. All rights reserved.
//

import Foundation

protocol GamesServiceProtocol {
    var network: Networking { get }
    func searchGames(params: SearchGamesParameters, _ completion: @escaping (Result<SearchGamesResponse, Error>) -> Void)
}

struct SearchGamesParameters {
    var keyword: String
    var page = 1
    var pageSize = 10
}

struct GamesService: GamesServiceProtocol {
    var network: Networking
    
    init(network: Networking) {
        self.network = network
    }

    func searchGames(params: SearchGamesParameters, _ completion: @escaping (Result<SearchGamesResponse, Error>) -> Void) {
        let endpoint = GamesEndpoint.search(params: params)
        network.execute(endpoint, completion: completion)
    }
}
