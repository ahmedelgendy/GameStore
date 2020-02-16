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
    private var storage: Storage
    
    init(service: GamesServiceProtocol, storage: Storage) {
        self.service = service
        self.storage = storage
    }

    // MARK: - fetch games
    func searchGames(with params: SearchGamesParameters, completion: @escaping SearchGamesCallBack) {
        let url = GamesEndpoint.searchGames(params: params).urlRequest.url?.absoluteString
        if let data: SearchGamesResponse = storage.value(for: url!) {
            completion(.success(data))
        } else {
            service.searchGames(params: params) { result in
                switch result {
                case .success(let value):
                    guard let key = self.service.network.urlRequest.url?.absoluteString else {
                        fatalError()
                    }
                    self.storage.add(value: value , forKey: key)
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
                
            }
        }
    }
    
    // MARK: - Game Details
    func getGameDetails(id: Int, completion: @escaping GameDetailsCallBack) {
        service.getGameDetails(id: id, completion)
    }

}
