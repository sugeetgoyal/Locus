//
//  MockNetworkManager.swift
//  LocusWeather
//
//  Created by Sugeet Goyal on 01/06/22.
//

import Foundation
@testable import LocusWeather

final class MockNetworkManager: NetworkManagerProtocol {
    var fileName = String()

    func callURL(url: URL, completionHandler: @escaping (Result<Data,
                                                         NetworkError>) -> Void) {
        if let data = retreiveJSONData(from: fileName) {
            let result = Result<Data, NetworkError>(value: data, error: nil)
            completionHandler(result)
        } else {
            completionHandler(Result(value: nil, error: NetworkError.unKnown("Mock file not found")))
        }
    }
    
    func retreiveJSONData(from fileName: String) -> Data? {
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            return try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        } else {
            return nil
        }
    }
}
