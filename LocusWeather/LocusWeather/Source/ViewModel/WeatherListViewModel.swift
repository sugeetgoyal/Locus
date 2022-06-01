//
//  WeatherListViewModel.swift
//  LocusWeather
//
//  Created by Sugeet Goyal on 16/05/22.
//

import Foundation

enum WeatherError: Error {
    case wrongURL(String)
    case dataParsing(Error)
    case error(String)
}

protocol WeatherListViewModelDelegate {
    func refreshView()
    func serviceFailed(message: String)
}

class WeatherListViewModel {
    var delegate: WeatherListViewModelDelegate?
    var weatherList = [WeatherViewModel]()
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func getWeatherList(lat: String, long: String) throws {
//        let urlStr = String(format: HOST+FORECAST_API, arguments: [lat,long,APP_Key])
        
        //NOTE: Calling other API because there is an issue with the above API, it is not giving response and saying API key invalid. So the below API shows common weather details all locations
        
        let urlStr = String(format: API_HOST+FORECAST_API_ID, arguments: [APP_Key])
        
        guard let url = URL(string: urlStr) else {
            throw WeatherError.wrongURL("The url entered is not correct")
        }
        
        networkManager.callURL(url: url) {[weak self] (result) in
            switch result {
            case .success(let data):
                self?.updateViewModel(data: data, completionHandler: { (model, error) in
                    if let err = error {
                        switch err {
                        case .dataParsing(let error):
                            print(error.localizedDescription)
                        case .error(let message):
                            print(message)
                        default:
                            print("Unknown Error!")
                        }
                    } else {
                        self?.weatherList = model
                        self?.delegate?.refreshView()
                    }
                })
            case .failure(let error):
                switch error {
                case .fetchFailed(_):
                    self?.delegate?.serviceFailed(message: error.localizedDescription)
                case .unKnown(let message):
                    self?.delegate?.serviceFailed(message: message)
                }
            }
        }
    }
    
    func updateViewModel(data: Data, completionHandler: ([WeatherViewModel], WeatherError?) -> Void) {
        var model = [WeatherViewModel]()
        do {
            let weatherModel = try JSONDecoder().decode(WeatherModel.self, from: data)
            
            for resItem in weatherModel.list {
                let weather = WeatherViewModel()
                
                weather.temp = String(resItem.main.temp)
                weather.feelsLikeTemp = String(resItem.main.feels_like)
                weather.description = resItem.weather.first?.description ?? ""
                weather.weatherStatus = resItem.weather.first?.main ?? ""
                
                model.append(weather)
            }
            
            completionHandler(model, nil)
        } catch {
            completionHandler(model, WeatherError.dataParsing(error))
        }
    }
}

class WeatherViewModel {
    var temp: String = ""
    var feelsLikeTemp: String = ""
    var weatherStatus: String = ""
    var description: String = ""
}
