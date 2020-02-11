//
//  SearchViewModel.swift
//  GamesApp
//
//  Created by Elgendy on 11.02.2020.
//  Copyright © 2020 Elgendy. All rights reserved.
//

import Foundation

protocol SearchViewModelDelegate: class {
    func onFetchCompleted(showLoadingCell: Bool)
    func onFetchFailed(reason: String)
}

class SearchViewModel {
    
    weak var delegate: SearchViewModelDelegate?
    private var service: GamesServiceProtocol
    private var games = [Game]()
    
    init(service: GamesServiceProtocol) {
        self.service = service
    }
    
    func search(with keyword: String) {
        print("Searching started for \(keyword)...")
        service.searchGames(params: SearchGamesParameters(keyword: keyword)) { (result) in
            switch result {
            case .success(let value):
                DispatchQueue.main.async {
                    self.games = value.results ?? []
                    self.delegate?.onFetchCompleted(showLoadingCell: false)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.delegate?.onFetchFailed(reason: error.localizedDescription)
                    print(error)
                }
            }
        }
    }
    
    func numberOfItems() -> Int {
        return self.games.count
    }
    
    func cellViewModelAt(index: Int) -> SearchCellViewModel {
        return SearchCellViewModel(game: self.games[index])
    }
}
