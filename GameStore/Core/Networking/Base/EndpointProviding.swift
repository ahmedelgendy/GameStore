//
//  EndpointProviding.swift
//  GameStore
//
//  Created by Elgendy on 11.02.2020.
//  Copyright © 2020 Elgendy. All rights reserved.
//

import Foundation


/// Every endpoint enum have to conform to this protocol
public protocol EndpointProviding {
    var urlRequest: URLRequest { get }
}
