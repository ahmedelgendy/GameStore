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
    
    private var workItem: DispatchWorkItem?
    private var viewModel: SearchViewModel!
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
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

// MARK: - SearchViewModelDelegate
extension SearchViewController: SearchViewModelDelegate {
    func onFetchCompleted(showLoadingCell: Bool) {
        collectionView.reloadData()
    }
    
    func onFetchFailed(reason: String) {
        
    }
}


// MARK: - UICollectionViewDelegate
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: SearchCollectionViewCell.self, for: indexPath)
        let cellViewModel = viewModel.cellViewModelAt(index: indexPath.row)
        cell.configure(viewModel: cellViewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return handleItemSize(collectionView)
    }
    
}

// MARK: - CollectionView Helper Methods
extension SearchViewController {
    fileprivate func handleItemSize(_ collectionView: UICollectionView) -> CGSize {
        var itemWidth: CGFloat!
        let orientation = UIApplication.shared.statusBarOrientation
        let deviceType = UI_USER_INTERFACE_IDIOM()
        if deviceType == .pad {
            if orientation.isLandscape {
                itemWidth = collectionView.frame.width/3
            } else {
               itemWidth = collectionView.frame.width/2
            }
        } else if deviceType == .phone {
            itemWidth = collectionView.frame.width
        }
        return CGSize(width: itemWidth, height: 136)
    }
}


// MARK: - UISearchResultsUpdating
extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text,
            text.count > 3 {
            performSearch(with: text)
        } else {
            print("nothing to search")
        }
    }
    
    func performSearch(with keyword: String) {
        workItem?.cancel() // cancel any pending requests
        
        workItem = DispatchWorkItem(block: { [weak self] in
            self?.viewModel.search(with: keyword)
        })
        
        // delay added to prevent realtime requests to the network
        let requestDelay = DispatchTime.now() + TimeInterval(exactly: 0.75)!
        let backgroundQueue = DispatchQueue.global(qos: .background)
        backgroundQueue.asyncAfter(deadline: requestDelay, execute: workItem!)
    }
}


