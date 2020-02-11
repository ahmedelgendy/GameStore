//
//  SearchCollectionViewCell.swift
//  GamesApp
//
//  Created by Elgendy on 10.02.2020.
//  Copyright © 2020 Elgendy. All rights reserved.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var metacriticLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(viewModel: SearchCellViewModel) {
        nameLabel.text = viewModel.name
        metacriticLabel.text = viewModel.metacritic
        genreLabel.text = viewModel.genres
    }
}

struct SearchCellViewModel {
    private var game: Game
    
    init(game: Game) {
        self.game = game
    }
    
    var name: String? { game.name }
    
    var metacritic: String? {
        if let metacritic = game.metacritic {
            return "\(metacritic)"
        } else {
            return nil
        }
    }
    
    var imageURL: URL? {
        return URL(string: game.backgroundImage ?? "")
    }
    
    var genres: String? {
        return game.genres.map({ $0.name }).joined(separator: " ,")
    }
    
}
