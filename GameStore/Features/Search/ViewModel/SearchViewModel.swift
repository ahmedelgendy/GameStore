//
//  SearchViewModel.swift
//  GameStore
//
//  Created by Elgendy on 11.02.2020.
//  Copyright © 2020 Elgendy. All rights reserved.
//

import Foundation

protocol SearchViewModelDelegate: class {
    func onFetchCompleted(loadMoreData: Bool)
    func onFetchFailed(reason: String)
}

class SearchViewModel {
    
    weak var delegate: SearchViewModelDelegate?

    private var repository: GameRepository
    private var games = [Game]()
    private var throttler = Throttler(delay: 0.7)
    private var searchParams = SearchGamesParameters()

    var loadMoreData = false
    
    init(repository: GameRepository) {
        self.repository = repository
    }
    
    func resetState() {
        games = []
        searchParams.page = 1
        loadMoreData = false
    }
    
    func startNewSearch(with keyword: String) {
        resetState() // start with clean state
        searchParams.keyword = keyword
        throttler.throttle { [unowned self] in
            self.search()
        }
    }
    
    func search() {
        print("Searching started for \(String(describing: searchParams.keyword))...")
        repository.searchGames(with: searchParams) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let value):
                    if self.searchParams.page == 1 {
                        self.games = value.results ?? []
                    } else {
                        self.games.append(contentsOf: value.results ?? [])
                    }
                    if let _ = value.next {
                        self.loadMoreData = true
                        self.searchParams.page += 1
                    }
                    self.delegate?.onFetchCompleted(loadMoreData: self.loadMoreData)
                case .failure(let error):
                    self.delegate?.onFetchFailed(reason: error.localizedDescription)
                }
            }
        }
    }
    
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        guard loadMoreData else { return false }
        return indexPath.row == (numberOfItems() - 1)
    }
    
    func numberOfItems() -> Int {
        return loadMoreData ? (self.games.count + 1) : self.games.count
    }
    
    func cellViewModelAt(index: Int) -> SearchCellViewModel {
        return SearchCellViewModel(game: self.games[index])
    }
    
    func gameIdAt(index: Int) -> Int {
        self.games[index].id
    }
    
}
