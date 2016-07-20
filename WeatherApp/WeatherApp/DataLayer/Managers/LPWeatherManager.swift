//
//  LPWeatherManager.swift
//  WeatherApp
//
//  Created by Lyubomyr Hlozhyk on 7/19/16.
//  Copyright © 2016 Lyupko. All rights reserved.
//

import Foundation
import UIKit

class LPWeatherManager {
    
    static let instance = LPWeatherManager()
    
    func getDefaultWeather() {
        LPLocationManager.instance.registerLocation()
    }
    
    func getWeatherByCurrentLocation() {
    
    }
    
    init() {
    }
    

    
}

