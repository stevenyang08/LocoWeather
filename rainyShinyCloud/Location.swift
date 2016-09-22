//
//  Location.swift
//  rainyShinyCloud
//
//  Created by Steven Yang on 9/19/16.
//  Copyright © 2016 Steven Yang. All rights reserved.
//

import CoreLocation

class Location {
    static var sharedInstance = Location()
    private init() {}
    var latitude: Double!
    var longitude: Double!
}
