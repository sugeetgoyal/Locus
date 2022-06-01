//
//  NetworkManager.swift
//  LocusWeather
//
//  Created by Sugeet Goyal on 16/05/22.
//

import Foundation

enum NetworkError: Error {
    case fetchFailed(Error)
    case unKnown(String)
}

enum Result<Success, Failure: Error> {
    case success(Success)
    case failure(Failure)
}

extension Result {
    init(value: Success?, error: Failure?) {
        if let error = error {
            self = .failure(error)
        } else if let value = value {
            self = .success(value)
        } else {
            fatalError("Could not create Result")
        }
    }
}

protocol NetworkManagerProtocol {
    func callURL(url: URL, completionHandler: @escaping (Result<Data,
                                                         NetworkError>) -> Void)
}

final class NetworkManager: NetworkManagerProtocol {    
    func callURL(url: URL, completionHandler: @escaping (Result<Data,
                                                         NetworkError>) -> Void) {
        let task = URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) -> Void in
            let dataTaskError = error.map { NetworkError.fetchFailed($0)}
            
            let result = Result<Data, NetworkError>(value: data, error:
                                                        dataTaskError)
            completionHandler(result)
        })
        
        task.resume()
    }
}
