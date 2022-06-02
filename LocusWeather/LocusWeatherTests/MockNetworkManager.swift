//
//  MockNetworkManager.swift
//  LocusWeather
//
//  Created by Sugeet Goyal on 01/06/22.
//

import Foundation
@testable import LocusWeather

class FeathcError: Error {
    init() {
        
    }
}

final class MockNetworkManager: NetworkManagerProtocol {
    var fileName = String()
    var isFetchFailed = false

    func callURL(url: URL, completionHandler: @escaping (Result<Data,
                                                         NetworkError>) -> Void) {
        if let (data, error) = retreiveJSONData(from: fileName) {
            if data == nil && error == nil {
                completionHandler(Result(value: nil, error: NetworkError.unKnown("Mock file not found")))
            } else {
                let dataTaskError = error.map { NetworkError.fetchFailed($0)}
                
                if isFetchFailed {
                    let result = Result<Data, NetworkError>(value: data,
                                                            error: .fetchFailed(FeathcError()))
                    completionHandler(result)
                } else {
                    let result = Result<Data, NetworkError>(value: data, error:
                                                                dataTaskError)
                    completionHandler(result)
                }
            }
        } else {
            completionHandler(Result(value: nil, error: NetworkError.unKnown("Mock file not found")))
        }
    }
    
    func retreiveJSONData(from fileName: String) -> (Data?, Error?)? {
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return (data, nil)
            } catch (let error) {
                return (nil, error)
            }
        } else {
            return (nil, nil)
        }
    }
}
