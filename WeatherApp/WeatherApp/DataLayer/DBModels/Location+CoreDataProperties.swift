//
//  Location+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Lyubomyr Hlozhyk on 7/20/16.
//  Copyright © 2016 Lyupko. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Location {

    @NSManaged var city: String?
    @NSManaged var latitude: Double
    @NSManaged var longitude: Double
    @NSManaged var tempC: Int16
    @NSManaged var tempF: Int16
    @NSManaged var useLocation: Bool
    @NSManaged var weather: String?
    @NSManaged var zmw: String?
    @NSManaged var defaultWeather: Bool

}
