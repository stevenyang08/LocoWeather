//
//  WeatherTableViewCell.swift
//  rainyShinyCloud
//
//  Created by Steven Yang on 9/6/16.
//  Copyright © 2016 Steven Yang. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var weatherCellImage: UIImageView!
    @IBOutlet weak var weatherDay: UILabel!
    @IBOutlet weak var weather: UILabel!
    @IBOutlet weak var weatherHighTemp: UILabel!
    @IBOutlet weak var weatherLowTemp: UILabel!
    
    func configureCell(forecast: Forecast) {
        weatherHighTemp.text = forecast.highTemp
        weatherLowTemp.text = forecast.lowTemp
        weather.text = forecast.weatherType
        weatherDay.text = forecast.date
        weatherCellImage.image = UIImage(named: forecast.weatherType)
    }

}
