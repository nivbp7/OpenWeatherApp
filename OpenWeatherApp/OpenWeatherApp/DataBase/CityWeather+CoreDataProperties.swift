//
//  CityWeather+CoreDataProperties.swift
//  OpenWeatherApp
//
//  Created by niv ben-porath on 06/03/2020.
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
    @NSManaged public var currentTemp: String?
    @NSManaged public var currentTempDescription: String?

}
