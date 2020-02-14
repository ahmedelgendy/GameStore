//
//  GamesEndpoint.swift
//  GameStore
//
//  Created by Elgendy on 11.02.2020.
//  Copyright © 2020 Elgendy. All rights reserved.
//

import Foundation

enum GamesEndpoint: EndpointProviding {
    case searchGames(params: SearchGamesParameters)
    case gameDetails(gameId: Int)

    var urlRequest: URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = AppConstants.URL.scheme
        urlComponents.host = AppConstants.URL.host
        urlComponents.path = RequestPath.games.path

        switch self {
        case .searchGames(let params):
            urlComponents.addQuery(key: QueryKeys.search, value: params.keyword)
            urlComponents.addQuery(key: QueryKeys.page, value: "\(params.page)")
            urlComponents.addQuery(key: QueryKeys.pageSize, value: "\(params.pageSize)")
        case .gameDetails(let gameId):
            urlComponents.path = urlComponents.path + "/\(gameId)"
        }
        return URLRequest(url: urlComponents.url!)
    }
}

private struct QueryKeys {
    static let search = "search"
    static let page = "page"
    static let pageSize = "page_size"
}
