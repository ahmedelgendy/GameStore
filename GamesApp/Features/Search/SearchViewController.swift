//
//  SearchViewController.swift
//  GamesApp
//
//  Created by Elgendy on 10.02.2020.
//  Copyright © 2020 Elgendy. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

}

// MARK: - setup ui
extension SearchViewController {
    func setupUI() {
        setupNavigationBar()
        setupSearchBar()
        setupCollectionView()
    }
    
    private func setupNavigationBar() {
        title = "Games"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupSearchBar() {
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        navigationItem.searchController = search
    }
    
    private func setupCollectionView() {
        collectionView.register(cellType: SearchCollectionViewCell.self)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        collectionView.collectionViewLayout = layout
    }
    
}

// MARK: - UICollectionViewDelegate
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: SearchCollectionViewCell.self, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 136)
    }
    
}

// MARK: - UISearchResultsUpdating
extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
    
    }
}


