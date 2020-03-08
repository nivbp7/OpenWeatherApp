//
//  CityWeather+CoreDataProperties.swift
//  OpenWeatherApp
//
//  Created by niv ben-porath on 08/03/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//
//

import Foundation
import CoreData


extension CityWeather {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<CityWeather> {
        return NSFetchRequest<CityWeather>(entityName: "CityWeather")
    }

    @NSManaged public var cityId: NSNumber?
    @NSManaged public var currentTemp: NSNumber?
    @NSManaged public var currentTempDescription: String?
    @NSManaged public var cityName: String?
    @NSManaged public var lastUpdate: NSNumber?

}
