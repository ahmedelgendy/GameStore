//
//  UILabelView+isTruncated.swift
//  GamesApp
//
//  Created by Elgendy on 12.02.2020.
//  Copyright © 2020 Elgendy. All rights reserved.
//

import UIKit

extension UILabel {
    var isTruncated: Bool {
        guard let labelText = text else {
            return false
        }
        let labelTextSize = (labelText as NSString).boundingRect(
            with: CGSize(width: frame.size.width, height: .greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: [.font: font as Any],
            context: nil).size
        return labelTextSize.height > bounds.size.height
    }
}
