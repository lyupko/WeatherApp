//
//  WeatherConstant.swift
//  WeatherApp
//
//  Created by Lyubomyr Hlozhyk on 7/19/16.
//  Copyright © 2016 Lyupko. All rights reserved.
//

import Foundation

public struct WeatherConstant {
    
    public static let accessKey = "2e23ea0be16a6065"
    
    public static let baseURL = "http://api.wunderground.com/api/" + accessKey + "conditions"

    public static let autocompleteURL = "http://autocomplete.wunderground.com/"
}