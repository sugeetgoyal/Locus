//
//  WeatherListViewModelTests.swift
//  LocusWeatherTests
//
//  Created by Sugeet Goyal on 14/05/22.
//

import XCTest
@testable import LocusWeather

class WeatherListViewModelTests: XCTestCase {
    var viewModel: WeatherListViewModel!
    var mockNetworkManager: MockNetworkManager!
    var isWithoutFileName: Bool = false
    
    override func setUp() {
        self.mockNetworkManager = MockNetworkManager()
        viewModel = WeatherListViewModel(networkManager: mockNetworkManager)
        viewModel.delegate = self
    }
    
    func testUpdateViewModelWithFileName() {
        mockNetworkManager.fileName = "WeatherResponse"
        
        do {
            try viewModel.getWeatherList(lat: "22.079624", long: "82.139137")
        } catch {
            switch error {
            case WeatherError.wrongURL(let str) :
                XCTAssertFalse(true, str)
            default:
                XCTAssertFalse(true, "UnKnown")
            }
        }
    }
    
    func testUpdateViewModelWithoutFileName() {
        mockNetworkManager.fileName = "dcsdc"
        isWithoutFileName = true
        do {
            try viewModel.getWeatherList(lat: "22.079624", long: "82.139137")
        } catch {
            switch error {
            case WeatherError.wrongURL(let str) :
                XCTAssertFalse(true, str)
            default:
                XCTAssertFalse(true, "UnKnown")
            }
        }
    }
}

extension WeatherListViewModelTests: WeatherListViewModelDelegate {
    func refreshView() {
        XCTAssertTrue(true, "Success")
    }
    
    func serviceFailed(message: String) {
        XCTAssertTrue(isWithoutFileName, message)
    }
}
