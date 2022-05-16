//
//  WeatherDetailsViewController.swift
//  LocusWeather
//
//  Created by Sugeet Goyal on 16/05/22.
//

import UIKit

class WeatherDetailsViewController: UIViewController {
    @IBOutlet weak var weatherTempLabel: UILabel!
    @IBOutlet weak var feelsLikeTempLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UITextView!
    @IBOutlet weak var weatherStatusLabel: UILabel!
    var weatherViewModel: WeatherViewModel?
    var location: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = location ?? ""
        
        feelsLikeTempLabel.text = weatherViewModel?.feelsLikeTemp ?? ""
        weatherTempLabel.text = weatherViewModel?.temp ?? ""
        weatherStatusLabel.text = weatherViewModel?.weatherStatus ?? ""
        weatherDescriptionLabel.text = weatherViewModel?.description ?? ""
    }
    
    override func viewDidLayoutSubviews() {
        weatherDescriptionLabel.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
    }
}

