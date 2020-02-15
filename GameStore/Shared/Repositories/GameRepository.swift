//
//  GameRepository.swift
//  GameStore
//
//  Created by Elgendy on 14.02.2020.
//  Copyright © 2020 Elgendy. All rights reserved.
//

import Foundation

class GameRepository {
    
    private var service: GamesServiceProtocol!
    
    init(service: GamesServiceProtocol) {
        self.service = service
    }
    
}

// MARK: - fetch games
extension GameRepository {
    func searchGames(with params: SearchGamesParameters, completion: @escaping SearchGamesCallBack) {
        let url = GamesEndpoint.searchGames(params: params).urlRequest.url?.absoluteString
        if let data: SearchGamesResponse = CacheStorage.get(for: url!) {
            completion(.success(data))
        } else {
            service.searchGames(params: params) { result in
                switch result {
                case .success(let value):
                    guard let key = self.service.network.urlRequest.url?.absoluteString else {
                        fatalError()
                    }
                    CacheStorage.add(value: value , forKey: key)
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
                
            }
        }
    }
}
