//
//  WeatherViewController.swift
//  rainyShinyCloud
//
//  Created by Steven Yang on 9/6/16.
//  Copyright © 2016 Steven Yang. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class WeatherViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var currentWeather = CurrentWeather()
    var forecast: Forecast!
    var forecasts = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
            
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    override func viewDidAppear(_ animated: Bool) {
        locationAuthorizationStatus()
    }
    
    func locationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            currentWeather.downloadWeatherDetails {
                self.downloadForcastData {
                    self.updateMainUI()
                }
            }
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthorizationStatus()
        }
    }
    
    func downloadForcastData(completed: DownloadComplete) {
        //Download Forecast Weather Data for TableView
        let forecastURL = URL(string: FORECAST_URL)!
        Alamofire.request(forecastURL, method: .get).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    
                    for obj in list {
                        let forecast = Forecast(weatherDict: obj)
                        print(obj)
                        self.forecasts.append(forecast)
                    }
                    self.forecasts.remove(at: 0)
                    self.tableView.reloadData()
                }
                
            }
            completed()
        }
    }
    
    func updateMainUI() {
        dateLabel.text = currentWeather.date
        currentTempLabel.text = "\(currentWeather.currentTemp)"
        currentWeatherLabel.text = currentWeather.weatherType
        locationLabel.text = currentWeather.cityName
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
    }

}

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? WeatherTableViewCell {
            let forecast = forecasts[indexPath.row]
            cell.configureCell(forecast: forecast)
            return cell
        } else {
            return WeatherTableViewCell()
        }
    }
}
