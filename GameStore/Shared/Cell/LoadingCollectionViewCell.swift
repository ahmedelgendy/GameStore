//
//  LoadingCollectionViewCell.swift
//  GameStore
//
//  Created by Elgendy on 11.02.2020.
//  Copyright © 2020 Elgendy. All rights reserved.
//

import UIKit

class LoadingCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        activityIndicator.startAnimating()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        activityIndicator.style = .gray
    }

}
