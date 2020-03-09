//
//  CityForecastAggregator.swift
//  OpenWeatherApp
//
//  Created by niv ben-porath on 09/03/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import Foundation

struct CityForecastForDataBase {
    var cityId: NSNumber
    var cityName: String
    
    var currentDate: Date
    var currectDateTemp: NSNumber?
    
    var firstDateTemp: NSNumber?
    var secondDateTemp: NSNumber?
    var thirdDateTemp: NSNumber?
    var fourthDateTemp: NSNumber?
    var fifthDayeTemp: NSNumber?
}


struct CityForecastAggregator {
    
    private var fullCityForecastForFiveDays : FullCityForecastForFiveDays
    
    init(fullCityForecastForFiveDays : FullCityForecastForFiveDays) {
        self.fullCityForecastForFiveDays = fullCityForecastForFiveDays
    }
    
    func aggregate() -> CityForecastForDataBase {
        let cityId = NSNumber(value:fullCityForecastForFiveDays.city.id)
        let cityName = fullCityForecastForFiveDays.city.name
        
        let currentDate = fullCityForecastForFiveDays.list.first?.dtTxt.toDate(with: .fullDate)?.startOfDay ?? Date().startOfDay!
        
        var currectDateTemp : NSNumber?
        var firstDateTemp : NSNumber?
        var secondDateTemp : NSNumber?
        var thirdDateTemp : NSNumber?
        var fourthDateTemp : NSNumber?
        var fifthDayeTemp : NSNumber?
        var currentDay = 0
        
        for cityForcast in fullCityForecastForFiveDays.list {
            let dateText = cityForcast.dtTxt
            if dateText.contains("12:00:00") {
                //we search only for the temp at noon
                switch currentDay {
                case 0:
                    currectDateTemp = NSNumber(value: cityForcast.main.temp)
                case 1:
                    firstDateTemp = NSNumber(value:cityForcast.main.temp)
                case 2:
                    secondDateTemp = NSNumber(value:cityForcast.main.temp)
                case 3:
                    thirdDateTemp = NSNumber(value:cityForcast.main.temp)
                case 4:
                    fourthDateTemp = NSNumber(value:cityForcast.main.temp)
                case 5:
                    fifthDayeTemp = NSNumber(value:cityForcast.main.temp)
                    
                default:
                    break
                }
                
                currentDay = currentDay + 1
            }
        }
        
        let cityForecastForDataBase = CityForecastForDataBase(cityId: cityId, cityName: cityName, currentDate: currentDate, currectDateTemp: currectDateTemp, firstDateTemp: firstDateTemp, secondDateTemp: secondDateTemp, thirdDateTemp: thirdDateTemp, fourthDateTemp: fourthDateTemp, fifthDayeTemp: fifthDayeTemp)
        
        return cityForecastForDataBase
    }
    
    
}
