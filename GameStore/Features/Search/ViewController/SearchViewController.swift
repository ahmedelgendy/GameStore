//
//  SearchViewController.swift
//  GameStore
//
//  Created by Elgendy on 10.02.2020.
//  Copyright © 2020 Elgendy. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, AlertDisplayer {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var messageLabel: UILabel!
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
        registerObservers()
    }
    
    func registerObservers() {
           NotificationCenter.default.addObserver(
               self, selector: #selector(updateCells),
               name: .seenItemsUpdated, object: nil
           )
    }
    
    @objc func updateCells() {
        collectionView.reloadData()
    }
    
}

// MARK: - setup ui
extension SearchViewController {
    private func setupUI() {
        setupNavigationBar()
        setupSearchBar()
        setupCollectionView()
        activityIndicator.hidesWhenStopped = true
    }
    
    private func setupNavigationBar() {
        title = "Games"
        navigationController?.navigationBar.prefersLargeTitles = true
        self.definesPresentationContext = true
    }
    
    private func setupSearchBar() {
        search.searchBar.delegate = self
        search.searchBar.placeholder = "Search for the games"
        search.dimsBackgroundDuringPresentation = false
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.showsCancelButton = true
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
    func onFetchCompleted(loadMoreData: Bool) {
        collectionView.reloadData()
        self.search.searchBar.endEditing(true)
        if viewModel.numberOfItems() == 0 {
            messageLabel.isHidden = false
            messageLabel.text = "No results found"
        } else {
            messageLabel.isHidden = true
        }
        activityIndicator.stopAnimating()
    }
    
    func onFetchFailed(reason: String) {
        collectionView.reloadData()
        activityIndicator.stopAnimating()
        let action = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
            self.dismiss(animated: true)
        }
        displayAlert(with: "Error", message: reason, actions: [action])
    }
}


// MARK: - UICollectionViewDelegate
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isLoadingCell(for: indexPath) {
            let cell = collectionView.dequeueReusableCell(with: LoadingCollectionViewCell.self, for: indexPath)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(with: SearchCollectionViewCell.self, for: indexPath)
            let cellViewModel = viewModel.cellViewModelAt(index: indexPath.row)
            cell.configure(viewModel: cellViewModel)
            cell.contentView.backgroundColor = cellViewModel.isCellSelected ? R.color.selectedCell() : .white
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if isLoadingCell(for: indexPath) {
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
}

// MARK: - UICollectionViewDelegateFlowLayout
extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if isLoadingCell(for: indexPath) {
            return CGSize(width: collectionView.frame.width, height: 100)
        } else {
            return handleItemSize(collectionView)
        }
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
    
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        guard viewModel.loadMoreData else { return false }
        return indexPath.row == (viewModel.numberOfItems() - 1)
     }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let text = searchBar.text,
            text.count > 3 {
            activityIndicator.startAnimating()
            messageLabel.isHidden = true
            viewModel.startNewSearch(with: text)
            collectionView.reloadData()
        } else {
            print("nothing to search")
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.resetState() // start with clean state
        collectionView.reloadData()
        messageLabel.isHidden = false
        messageLabel.text = "No game has been searched."
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
}
