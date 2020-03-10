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
    var cityId : NSNumber
    var lastUpdate : String
}


final class CityWeatherViewModel {
    
    private var allCitiesWeather = [CityWeather]()
    
    func updateAllCityWeather(cityWeatherArray : [CityWeather]){
        allCitiesWeather.removeAll()
        allCitiesWeather = cityWeatherArray
    }
    
    func shownWeather(at index : Int) -> ShownWeather {
        
        guard index < allCitiesWeather.count else {
            preconditionFailure(Texts.noItemInRow)
        }
        
        let cityWeather = allCitiesWeather[index]
        let cityName = cityWeather.cityName ?? ""
        var cityTemp = "--" + Values.degreeSign
        if let currentTemp = cityWeather.currentTemp {
            cityTemp = String(Int(truncating: currentTemp)) + Values.degreeSign
        }
        let tempDescription = cityWeather.currentTempDescription ?? ""
        let cityId = cityWeather.cityId ?? NSNumber(value: 0)
        
        var lastUpdateString = Texts.updated + "--:--"
        if let timeInteravl = cityWeather.lastUpdate?.doubleValue {
            lastUpdateString = Texts.updated + Date(timeIntervalSince1970:timeInteravl).toString(with: .time)
        }
        
        let shownWeather = ShownWeather(cityName: cityName, cityTemp: cityTemp, tempDescription: tempDescription, cityId: cityId, lastUpdate: lastUpdateString)
        return shownWeather
    }
    
    func numberOfCities() -> Int {
        return allCitiesWeather.count
    }
    
}
