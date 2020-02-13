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
    
    lazy var search: UISearchController = {
        UISearchController(searchResultsController: nil)
    }()
    
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
    private func setupUI() {
        setupNavigationBar()
        setupSearchBar()
        setupCollectionView()
    }
    
    private func setupNavigationBar() {
        title = "Games"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupSearchBar() {
        search.searchBar.delegate = self
        search.searchBar.placeholder = "Search for the games"
        search.dimsBackgroundDuringPresentation = false
        search.hidesNavigationBarDuringPresentation = false
        search.searchBar.showsCancelButton = false
        navigationItem.searchController = search
    }
    
    private func setupCollectionView() {
        collectionView.register(cellType: SearchCollectionViewCell.self)
        collectionView.register(cellType: LoadingCollectionViewCell.self)
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
}

// MARK: - SearchViewModelDelegate
extension SearchViewController: SearchViewModelDelegate {
    func onFetchCompleted(showLoadingCell: Bool) {
        collectionView.reloadData()
        self.search.searchBar.endEditing(true)
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
        if viewModel.isLoadingCell(for: indexPath) {
            let cell = collectionView.dequeueReusableCell(with: LoadingCollectionViewCell.self, for: indexPath)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(with: SearchCollectionViewCell.self, for: indexPath)
            let cellViewModel = viewModel.cellViewModelAt(index: indexPath.row)
            cell.configure(viewModel: cellViewModel)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if viewModel.isLoadingCell(for: indexPath) {
            viewModel.search()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = viewModel.gameIdAt(index: indexPath.row)
        let service = GamesService(network: Networking())
        let detailsViewModel = DetailsViewModel(gameId: id, service: service, favoriteRepository: FavoriteRepository())
        let detailsViewController = DetailsViewController(viewModel: detailsViewModel)
        present(detailsViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if viewModel.isLoadingCell(for: indexPath) {
            return CGSize(width: collectionView.frame.width, height: 100)
        } else {
            return handleItemSize(collectionView)
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    }
}

// MARK: - CollectionView Helper Methods
extension SearchViewController {
    fileprivate func handleItemSize(_ collectionView: UICollectionView) -> CGSize {
        var itemWidth: CGFloat!
        let orientation = UIApplication.shared.statusBarOrientation
        let deviceType = UI_USER_INTERFACE_IDIOM()
        let width = collectionView.frame.width
        if deviceType == .pad {
            itemWidth =  orientation.isLandscape ? (width/3) : (width/2)
        } else if deviceType == .phone {
            itemWidth = width
        }
        return CGSize(width: itemWidth, height: 136)
    }
}


extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let text = searchBar.text,
            text.count > 3 {
            performSearch(with: text)
        } else {
            print("nothing to search")
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
}

extension SearchViewController {

    func performSearch(with keyword: String) {
        viewModel.resetState() // start with clean state
        workItem?.cancel() // cancel any pending requests
        workItem = DispatchWorkItem(block: { [weak self] in
            self?.viewModel.searchKeyword = keyword
            self?.viewModel.search()
        })
        // delay added to prevent realtime requests to the network
        let requestDelay = DispatchTime.now() + TimeInterval(exactly: 0.75)!
        let backgroundQueue = DispatchQueue.global(qos: .background)
        backgroundQueue.asyncAfter(deadline: requestDelay, execute: workItem!)
    }
}


