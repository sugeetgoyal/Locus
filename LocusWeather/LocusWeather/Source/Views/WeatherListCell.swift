//
//  WeatherListCell.swift
//  LocusWeather
//
//  Created by Sugeet Goyal on 16/05/22.
//

import UIKit

class WeatherListCell: UITableViewCell {
    @IBOutlet weak var weatherStatus: UILabel!
    @IBOutlet weak var weatherTemp: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
}
