//
//  WeatherListViewModel.swift
//  LocusWeather
//
//  Created by Sugeet Goyal on 16/05/22.
//

import Foundation

protocol WeatherListViewModelDelegate {
    func refreshViewOnSuccess()
    func onFailure(message: String)
}

class WeatherListViewModel {
    var delegate: WeatherListViewModelDelegate?
    var weatherList = [WeatherViewModel]()
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func getWeatherList(lat: String, long: String) {
//        let urlStr = String(format: HOST+FORECAST_API, arguments: [lat,long,APP_Key])
        
        //NOTE: Calling other API because there is an issue with the above API, it is not giving response and saying API key invalid. So the below API shows common weather details all locations
        
        let urlStr = String(format: API_HOST+FORECAST_API_ID, arguments: [APP_Key])
        
        guard let url = URL(string: urlStr) else {
            delegate?.onFailure(message: "The url entered is not correct")
            return
        }
        
        networkManager.callURL(url: url) {[weak self] (result) in
            switch result {
            case .success(let data):
                self?.updateViewModel(data: data, completionHandler: { (model, errorMessage) in
                    if let msg = errorMessage {
                        self?.delegate?.onFailure(message: msg)
                    } else {
                        self?.weatherList = model
                        self?.delegate?.refreshViewOnSuccess()
                    }
                })
            case .failure(let error):
                switch error {
                case .fetchFailed(_):
                    self?.delegate?.onFailure(message: error.localizedDescription)
                case .unKnown(let message):
                    self?.delegate?.onFailure(message: message)
                }
            }
        }
    }
    
    func updateViewModel(data: Data, completionHandler: (_ dataModel: [WeatherViewModel], _ errorMessage: String?) -> Void) {
        var model = [WeatherViewModel]()
        do {
            let weatherModel = try JSONDecoder().decode(WeatherModel.self, from: data)
            
            for resItem in weatherModel.list {
                let weather = WeatherViewModel(temp: String(resItem.main.temp),
                                               feelsLikeTemp: String(resItem.main.feels_like),
                                               weatherStatus: resItem.weather.first?.description ?? "",
                                               description: resItem.weather.first?.main ?? "")
                model.append(weather)
            }
            
            completionHandler(model, nil)
        } catch let error as DecodingError {
            switch error {
            case .typeMismatch(_, let context):
                completionHandler(model, "debugDescription: " + context.debugDescription + "codingPath: " + "\(context.codingPath)")
            default:
                completionHandler(model, error.localizedDescription)
            }
        } catch {
            completionHandler(model, error.localizedDescription)
        }
    }
}

struct WeatherViewModel {
    let temp: String
    let feelsLikeTemp: String
    let weatherStatus: String
    let description: String
}
