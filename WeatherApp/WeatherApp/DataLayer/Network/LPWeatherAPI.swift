//
//  LPWeatherAPI.swift
//  WeatherApp
//
//  Created by Lyubomyr Hlozhyk on 7/19/16.
//  Copyright © 2016 Lyupko. All rights reserved.
//

import Foundation

import Alamofire
import ObjectMapper

class LPWeatherAPI {
    
    class func searchLocation(query query: String?, completion: CompletionBlock?) -> Request {
        return request(.GET, baseURL: WeatherConstant.autocompleteURL, endpoint: "aq", parameters: ["query": query ?? ""], completion: completion)
    }
    
    class func getWeatherByCurrentLocation(completion: CompletionBlock?) -> Request {
        let coordinate = LPLocationManager.instance.currentCoordinate
        
        let params = ["lon": coordinate.longitude,
                      "lat": coordinate.latitude
                      ]
        return request(.GET, baseURL: WeatherConstant.autocompleteURL, endpoint: "aq", parameters: params, completion: completion)
    }
    
    class func getWeather(zmw zmw: String?, completion: CompletionBlock?) -> Request {
        let params = ["zmw": zmw ?? ""]
        return request(.GET, baseURL: WeatherConstant.autocompleteURL, endpoint: "aq", parameters: params, completion: completion)
    }
}


public typealias CompletionBlock = (object: AnyObject?, success: Bool, message: String?) -> Void

extension LPWeatherAPI {
    
    class func request(method: Alamofire.Method,
                       baseURL: String = WeatherConstant.baseURL,
                       endpoint: String,
                       parameters: [String: AnyObject]? = nil,
                       encoding: ParameterEncoding = .URL,
                       headers: [String: String]? = nil,
                       completion: CompletionBlock?) -> Request {
        
        return Alamofire.request(method, baseURL + endpoint, parameters: parameters, encoding: encoding, headers: headers).validate(statusCode: 200..<300).validate(contentType: ["application/json"])
            .responseJSON { response in
                debugPrint(response.request)
                debugPrint(response.result.value)
                
                guard completion != nil else {
                    return
                }
                
                guard response.result.error == nil else {
                    completion!(object: nil, success: false, message: "An internal error occured")
                    return
                }
                
                completion!(object: response.result.value, success: true, message: "Success")
        }
    }
}