//
//  Constants.swift
//  LocusWeather
//
//  Created by Sugeet Goyal on 16/05/22.
//

import UIKit

let APP_Key = "65d00499677e59496ca2f318eb68c049"
let HOST = "https://pro.openweathermap.org/data/2.5/"
let FORECAST_API = "forecast/hourly?lat=%@&lon=%@&appid=%@"
let API_HOST = "https://api.openweathermap.org/data/2.5/"
let FORECAST_API_ID = "forecast?id=524901&appid=%@"

func showAlert(in vc: UIViewController, with title: String, message: String) {
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
        
        switch action.style{
            case .default:
            print("default")
            
            case .cancel:
            print("cancel")
            
            case .destructive:
            print("destructive")
            
        default:
            fatalError()
        }
    }))
    
    vc.present(alert, animated: true, completion: nil)
}
