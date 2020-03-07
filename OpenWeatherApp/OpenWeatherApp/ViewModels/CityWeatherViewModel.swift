//
//  CityWeatherViewModel.swift
//  OpenWeatherApp
//
//  Created by niv ben-porath on 07/03/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import Foundation

class CityWeatherViewModel {
    
    private var allCitiesWeather : [CityWeather]
    
    init(allCitiesWeather : [CityWeather]) {
        self.allCitiesWeather = allCitiesWeather
    }
    
    func cityWeather(at index : Int) -> CityWeather? {
        if index > allCitiesWeather.count {
            return nil
        }
        
        let cityWeather = allCitiesWeather[index]
        return cityWeather
    }
    
    func numberOfCities() -> Int {
        return allCitiesWeather.count
    }
    
}
