//
//  LPLocationManager.swift
//  WeatherApp
//
//  Created by Lyubomyr Hlozhyk on 7/19/16.
//  Copyright © 2016 Lyupko. All rights reserved.
//

import Foundation
import CoreLocation

class LPLocationManager: NSObject {
    
    static let instance = LPLocationManager()
    
    var currentCoordinate: CLLocationCoordinate2D {
        return coordinate!
    }
    private var coordinate: CLLocationCoordinate2D? = nil
    private var locationController: CLLocationManager? = nil
    
    override init() {
      super.init()
    }
    
    private func setUpLocationController() {
        locationController = CLLocationManager()
        locationController!.delegate = self
        locationController!.desiredAccuracy = kCLLocationAccuracyBest
        locationController!.distanceFilter = kCLDistanceFilterNone
        locationController!.requestAlwaysAuthorization()
        locationController!.startUpdatingLocation()
    
        if CLLocationManager.locationServicesEnabled() {
            locationController!.startUpdatingLocation()
        }
        
        coordinate = (locationController!.location?.coordinate)!
    }
}

extension LPLocationManager: CLLocationManagerDelegate {
    
    @objc func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            coordinate = location.coordinate
        }
    }
}