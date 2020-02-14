//
//  UILabelView+isTruncated.swift
//  GameStore
//
//  Created by Elgendy on 12.02.2020.
//  Copyright © 2020 Elgendy. All rights reserved.
//

import UIKit

extension UILabel {
    var isTruncated: Bool {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: .greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = self.font
        label.text = self.text
        label.sizeToFit()
        if label.frame.height > self.frame.height {
            return true
        }
        return false
    }
}
