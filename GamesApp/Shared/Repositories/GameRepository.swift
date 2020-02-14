//
//  GameRepository.swift
//  GamesApp
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
        if let data = LocalStorage.getValue(for: url!) as? Data {
            do {
                let model = try JSONDecoder().decode(SearchGamesResponse.self, from: data)
                completion(.success(model))
            } catch { }
        } else {
            service.searchGames(params: params) { result in
                switch result {
                case .success(let value):
                    let key = self.service.network.urlRequest.url?.absoluteString
                    do {
                        let json = try JSONEncoder().encode(value)
                        LocalStorage.add(value: json , forKey: key!)
                    } catch { }
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
                
            }
        }
    }
}
