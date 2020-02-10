//
//  ClassName.swift
//  GamesApp
//
//  Created by Elgendy on 10.02.2020.
//  Copyright © 2020 Elgendy. All rights reserved.
//

import Foundation

public protocol ClassNameProtocol {
    static var className: String { get }
    var className: String { get }
}

public extension ClassNameProtocol {
    static var className: String {
        return String(describing: self)
    }

    var className: String {
        return type(of: self).className
    }
}

extension NSObject: ClassNameProtocol {}
