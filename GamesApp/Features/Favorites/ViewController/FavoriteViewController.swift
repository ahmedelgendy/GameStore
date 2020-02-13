//
//  FavoriteViewController.swift
//  GamesApp
//
//  Created by Elgendy on 10.02.2020.
//  Copyright © 2020 Elgendy. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var messageLabel: UILabel!
    
    private var viewModel: FavoriteViewModel
    
    init(viewModel: FavoriteViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.delegate = self
        getFavoritedItems()
        registerObservers()
    }
    
    func registerObservers() {
        NotificationCenter.default.addObserver(
            self, selector: #selector(getFavoritedItems),
            name: .favoritedItemsUpdated, object: nil
        )
    }
    
    @objc func getFavoritedItems() {
        viewModel.getFavoritedItems()
    }

}


// MARK: - setup ui
extension FavoriteViewController {
    private func setupUI() {
        setupNavigationBar()
        setupCollectionView()
    }
    
    private func setupNavigationBar() {
        title = "Favorite"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = R.color.navigationbarColor()
    }
    
    private func setTitle(_ title: String) {
        self.title = title
    }
    
    private func setupCollectionView() {
        collectionView.register(cellType: FavoriteCollectionViewCell.self)
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
}

// MARK: - FavoriteViewModelDelegate
extension FavoriteViewController: FavoriteViewModelDelegate {
    func onFetchCompleted(isEmpty: Bool) {
        if !isEmpty {
            setTitle("Favorite (\(viewModel.numberOfItems()))")
        }
        messageLabel.isHidden = !isEmpty
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegate
extension FavoriteViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: FavoriteCollectionViewCell.self, for: indexPath)
        let cellViewModel = viewModel.cellViewModelAt(index: indexPath.row)
        cell.configure(viewModel: cellViewModel)
        return cell
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
        return handleItemSize(collectionView)
    }
    
}

// MARK: - CollectionView Helper Methods
extension FavoriteViewController {
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
