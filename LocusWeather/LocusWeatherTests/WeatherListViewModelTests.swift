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
    var isNegativeScenario: Bool = false
    
    override func setUp() {
        self.mockNetworkManager = MockNetworkManager()
        viewModel = WeatherListViewModel(networkManager: mockNetworkManager)
        viewModel.delegate = self
    }
    
    func testUpdateViewModelWithFileName() {
        mockNetworkManager.fileName = "WeatherResponse"
        isNegativeScenario = false
        viewModel.getWeatherList(lat: "22.079624", long: "82.139137")
    }
    
    func testUpdateViewModelWithoutFileName() {
        mockNetworkManager.fileName = "dcsdc"
        isNegativeScenario = true
        viewModel.getWeatherList(lat: "22.079624", long: "82.139137")
    }
    
    func testUpdateViewModelWithWrongMockData() {
        mockNetworkManager.fileName = "WrongWeatherResponse"
        isNegativeScenario = true
        viewModel.getWeatherList(lat: "22.079624", long: "82.139137")
    }
    
    func testUpdateViewModelWithWrongCod() {
        mockNetworkManager.fileName = "WrongCodWeatherResponse"
        isNegativeScenario = true
        viewModel.getWeatherList(lat: "22.079624", long: "82.139137")
    }
    
    func testUpdateViewModelForFetchFailed() {
        mockNetworkManager.fileName = "WeatherResponse"
        mockNetworkManager.isFetchFailed = true
        isNegativeScenario = true
        viewModel.getWeatherList(lat: "22.079624", long: "82.139137")
    }
}

extension WeatherListViewModelTests: WeatherListViewModelDelegate {
    func refreshViewOnSuccess() {
        XCTAssertTrue(true, "Success")
    }

    func onFailure(message: String) {
        XCTAssertTrue(isNegativeScenario, message)
    }
}
