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
    
    init() {
        
    }
    
    func search(with keyword: String) {
        print("Searching started for \(keyword)...")
    }
}
