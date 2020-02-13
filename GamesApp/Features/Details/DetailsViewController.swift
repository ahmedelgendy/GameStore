//
//  DetailsViewController.swift
//  GamesApp
//
//  Created by Elgendy on 12.02.2020.
//  Copyright © 2020 Elgendy. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var gameDescriptionLabel: UILabel!
    @IBOutlet weak var readMoreButton: UIButton!
    
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var mainStackView: UIStackView!
    
    private let viewModel: DetailsViewModel
    
    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainStackView.alpha = 0
        favoriteButton.isEnabled = false
        activityIndicator.startAnimating()
        viewModel.delegate = self
        viewModel.fetchDetails()
    }
    
    @IBAction func dismissView(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        viewModel.favorite()
    }
    
    @IBAction func readMoreButtonTapped(_ sender: Any) {
    }
    
    @IBAction func visitRedditButtonTapped(_ sender: Any) {
    }
    
    @IBAction func visitWebsiteButtonTapped(_ sender: Any) {
    }
    
}

// MARK: - DetailsViewModelDelegate
extension DetailsViewController: DetailsViewModelDelegate {
    
    func onFavorited() {
        favoriteButton.setTitle(viewModel.favoriteButtonTitle, for: .normal)
    }
    
    func onFetchCompleted() {
        imageView.kf.setImage(with: viewModel.imageURL)
        nameLabel.text = viewModel.name
        gameDescriptionLabel.text = viewModel.description
        mainStackView.alpha = 1
        activityIndicator.stopAnimating()
        favoriteButton.isEnabled = true
        favoriteButton.setTitle(viewModel.favoriteButtonTitle, for: .normal)
    }
    
    func onFetchFailed(reason: String) {
        activityIndicator.stopAnimating()
    }
}

