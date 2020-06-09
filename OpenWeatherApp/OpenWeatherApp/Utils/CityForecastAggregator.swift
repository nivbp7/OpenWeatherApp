//
//  CityForecastAggregator.swift
//  OpenWeatherApp
//
//  Created by niv ben-porath on 09/03/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import Foundation

/*
 this object turns the forecast data fetched from the network into data which can be saved to DB
 */

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
        
        //get the start of date for the first day in the forecast
        let currentDate = fullCityForecastForFiveDays.list.first?.dtTxt.toDate(with: .fullDate)?.startOfDay ?? Date().startOfDay!
        
       
        
        var currectDateTemp : NSNumber?
        var firstDateTemp : NSNumber?
        var secondDateTemp : NSNumber?
        var thirdDateTemp : NSNumber?
        var fourthDateTemp : NSNumber?
        var fifthDateTemp : NSNumber?
        
        
        //we need to check if the first item is before or after 12:00
        //if it is before 12:00, we will use today's 12:00 temp as today's current temp
        //if it is after 12:00, we will use the first itme's temp as today's current temp
        
        var currentDay = 0
        
        if let isAfterNoon = fullCityForecastForFiveDays.list.first?.dtTxt.toDate(with: .fullDate)?.isAfterNoon(), isAfterNoon {
            
            //if the first day is after 12:00, our 'currentDay' tracking below will start from '1' and the temp for the 'currentDay' will be taken from the 'first' value of the data (as seen below)
            currentDay = 1
            
            if let currectTemp = fullCityForecastForFiveDays.list.first?.main.temp {
                currectDateTemp = NSNumber(value: currectTemp)
            }
        }
        
        
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
                    fifthDateTemp = NSNumber(value:cityForcast.main.temp)
                    
                default:
                    break
                }
                
                currentDay = currentDay + 1
            }
        }
        
        //this is for cases where we did not get back a value for the fifth day at noon, so we take the last value for that date
        if fifthDateTemp == nil {
            if let day5temp = fullCityForecastForFiveDays.list.last?.main.temp {
                fifthDateTemp = NSNumber(value:day5temp)
            }
        }
        
        let cityForecastForDataBase = CityForecastForDataBase(cityId: cityId, cityName: cityName, currentDate: currentDate, currectDateTemp: currectDateTemp, firstDateTemp: firstDateTemp, secondDateTemp: secondDateTemp, thirdDateTemp: thirdDateTemp, fourthDateTemp: fourthDateTemp, fifthDayeTemp: fifthDateTemp)
        
        return cityForecastForDataBase
    }
}
