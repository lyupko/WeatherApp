//
//  Location.swift
//  WeatherApp
//
//  Created by Lyubomyr Hlozhyk on 7/19/16.
//  Copyright © 2016 Lyupko. All rights reserved.
//

import Foundation
import CoreData

class Location: NSManagedObject {

   class func createDefaultLocation() {
        
        let locationKiev = LPDBManager.sharedInstance.insertNewManagedObject(String(Location)) as! Location
        
        locationKiev.city = "Kiev, Ukraine"
        locationKiev.latitude = 50.433334
        locationKiev.longitude = 30.516666
        locationKiev.weather = ""
        locationKiev.tempF = 0
        locationKiev.tempC = 0
        locationKiev.useLocation = false
        locationKiev.defaultWeather = false
        locationKiev.zmw = "00000.8.33345"
    
        LPDBManager.sharedInstance.saveContext()
    }
    
    class func deleteLocation(entity: Location) {
        LPDBManager.sharedInstance.managedObjectContext.deleteObject(entity)
        LPDBManager.sharedInstance.saveContext()
    }
    
    
}
