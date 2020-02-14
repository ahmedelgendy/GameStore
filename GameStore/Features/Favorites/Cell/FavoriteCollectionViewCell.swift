//
//  SearchCollectionViewCell.swift
//  GameStore
//
//  Created by Elgendy on 10.02.2020.
//  Copyright © 2020 Elgendy. All rights reserved.
//

import UIKit
import Kingfisher

class FavoriteCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var metacriticLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    func configure(viewModel: FavoriteCellViewModel) {
        nameLabel.text = viewModel.name
        metacriticLabel.text = viewModel.metacritic
        genreLabel.text = viewModel.genres
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: viewModel.imageURL)
    }
}
