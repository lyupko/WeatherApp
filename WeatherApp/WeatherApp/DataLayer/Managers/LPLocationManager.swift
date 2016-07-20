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
    private var locationManager = CLLocationManager()
    
    override init() {
      super.init()
      setUpLocationController()
    }
    
    //MARK: - Public methods
    
    func registerLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    //MARK: - Private methods
    
    private func setUpLocationController() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
}

extension LPLocationManager: CLLocationManagerDelegate {
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            coordinate = location.coordinate
        }
        manager.stopUpdatingLocation()
        NSNotificationCenter.defaultCenter().postNotificationName("findLocationOfUser", object: self)
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
       
        if CLLocationManager.locationServicesEnabled() && CLLocationManager.authorizationStatus() == .Denied {
            NSNotificationCenter.defaultCenter().postNotificationName("locationDisabled", object: self)
        }
        
    }
}