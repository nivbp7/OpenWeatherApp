//
//  ShownCityViewModel.swift
//  OpenWeatherApp
//
//  Created by niv ben-porath on 10/03/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import Foundation
/*
 VM for showing the city weather

 */

struct ShownCityViewModel {
    
    private var cityName : String
    private var cityTemp : String
    private var cityId : NSNumber
    
    init(cityName: String, cityTemp: String, cityId: NSNumber) {
        self.cityName = cityName
        self.cityTemp = cityTemp
        self.cityId = cityId
    }
    
    func getCityName() -> String {
        return cityName
    }
  
    func getCityTemp() -> String {
        return cityTemp
    }
    
    func getCityId() -> NSNumber {
        return cityId
    }
    
    func getCityIdInt() -> Int {
        return cityId.intValue
    }
}
