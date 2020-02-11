//
//  Networking.swift
//  GamesApp
//
//  Created by Elgendy on 11.02.2020.
//  Copyright © 2020 Elgendy. All rights reserved.
//

import Foundation

public protocol NetworkingProtocol {
    var urlRequest: URLRequest! { get }
    func execute<T: Decodable>(_ requestProvider: EndpointProviding, completion: @escaping (Result<T, Error>) -> Void)
}

public class Networking: NetworkingProtocol {
        
    public var urlRequest: URLRequest!
    
    public func execute<T: Decodable>(_ endpointProvider: EndpointProviding, completion: @escaping (Result<T, Error>) -> Void) {
        urlRequest = endpointProvider.urlRequest
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            do {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else {
                    preconditionFailure("No Errors, but no data also!")
                }
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                print("Before decoding: \n", String(data: data, encoding: .utf8) as Any)
                let decodedObject = try decoder.decode(T.self, from: data)
                print("After decoding: \n", decodedObject)
                completion(.success(decodedObject))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}

