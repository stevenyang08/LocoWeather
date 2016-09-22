//
//  Constants.swift
//  rainyShinyCloud
//
//  Created by Steven Yang on 9/15/16.
//  Copyright © 2016 Steven Yang. All rights reserved.
//

import Foundation

var BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let LATITUDE = "lat="
let LATITUDE_COORDINATE = "\(Location.sharedInstance.latitude!)"
let LONGITUDE = "&lon="
let LONGITUDE_COORDINATE = "\(Location.sharedInstance.longitude!)"
let APP_ID = "&appid="
let API_Key = "1fbeb4dde32970c7ecc7149e1a40bd87"

typealias DownloadComplete = () -> ()

let CURRENT_WEATHER_URL = "\(BASE_URL)\(LATITUDE)\(LATITUDE_COORDINATE)\(LONGITUDE)\(LONGITUDE_COORDINATE)\(APP_ID)\(API_Key)"

var FORECAST_BASE_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?"
var CONTENTS = "&cnt=10"
var MODE_TYPE = "&mode=json"

let FORECAST_URL = "\(FORECAST_BASE_URL)\(LATITUDE)\(LATITUDE_COORDINATE)\(LONGITUDE)\(LONGITUDE_COORDINATE)\(CONTENTS)\(MODE_TYPE)\(APP_ID)\(API_Key)"

