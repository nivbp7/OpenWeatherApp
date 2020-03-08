//
//  CityWeatherViewModel.swift
//  OpenWeatherApp
//
//  Created by niv ben-porath on 07/03/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import Foundation

struct ShownWeather {
    var cityName : String
    var cityTemp : String
    var tempDescription : String
}


class CityWeatherViewModel {
    
    private var allCitiesWeather = [CityWeather]()
    
    func updateAllCityWeather(cityWeatherArray : [CityWeather]){
        allCitiesWeather.removeAll()
        allCitiesWeather = cityWeatherArray
    }
    
    func shownWeather(at index : Int) -> ShownWeather? {
        if index > allCitiesWeather.count {
            return nil
        }
        
        let cityWeather = allCitiesWeather[index]
        let cityName = cityWeather.cityName ?? ""
        var cityTemp = "--" + Values.degreeSign
        if let currentTemp = cityWeather.currentTemp {
            cityTemp = String(Int(truncating: currentTemp)) + Values.degreeSign
        }
        let tempDescription = cityWeather.currentTempDescription ?? ""
        let shownWeather = ShownWeather(cityName: cityName, cityTemp: cityTemp, tempDescription: tempDescription)
        return shownWeather
    }
    
    func numberOfCities() -> Int {
        return allCitiesWeather.count
    }
    
}
