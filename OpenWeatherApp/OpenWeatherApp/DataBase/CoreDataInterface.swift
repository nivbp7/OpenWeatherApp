//
//  CoreDataInterface.swift
//  OpenWeatherApp
//
//  Created by niv ben-porath on 06/03/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import Foundation
import CoreData

typealias CoreDataCompletion = (CoreDataError?) -> Void
typealias CoreDataFetchCompletion = (Result<CityWeather,CoreDataError>)
typealias CoreDataFullFetchCompletion = (Result<[CityWeather],CoreDataError>)

typealias CoreDateForecastFetchCompletion = (Result<CityForecast,CoreDataError>)

enum CoreDataError : Error {
    case coreDataError(errorMessage : String)
}

struct CoreDataInterface {
    
    let persistentContainer: NSPersistentContainer
    
    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }
    
    
    //MARK: - current weather
    func save(currentWeather : CurrentWeather, with completion : @escaping CoreDataCompletion) {
        persistentContainer.viewContext.perform {
            
            let cityId = currentWeather.id
            let coreDataFetch = self.fetch(cityId: cityId)
            switch coreDataFetch {
            case .success(let cityInDataBase):
                //we have this city in the DB
                cityInDataBase.currentTemp = NSNumber(value:currentWeather.main.temp)
                cityInDataBase.currentTempDescription = currentWeather.weather[0].description
                cityInDataBase.lastUpdate = NSNumber(value:Date().timeIntervalSince1970)// NSNumber(value:currentWeather.dt)
            case .failure(_):
                //city is not in DB, so add it
                let cityWeather = CityWeather(context: self.persistentContainer.viewContext)
                cityWeather.cityId = NSNumber(value: currentWeather.id)
                cityWeather.cityName = currentWeather.name
                cityWeather.currentTemp = NSNumber(value:currentWeather.main.temp)
                cityWeather.currentTempDescription = currentWeather.weather[0].description
                cityWeather.lastUpdate = NSNumber(value:currentWeather.dt)
            }
            do {
                try self.persistentContainer.viewContext.save()
                completion(nil)
            }catch{
                completion(.coreDataError(errorMessage: "saving error \(error.localizedDescription)"))
            }
        }
    }
    
    func fetch(cityId : Int) -> CoreDataFetchCompletion {
        let request = CityWeather.createFetchRequest()
        let predicate = NSPredicate(format: "cityId = %@", NSNumber(value: cityId))
        request.predicate = predicate
        
        do {
            let cityWeatherArray = try self.persistentContainer.viewContext.fetch(request)
            if let cityWeather = cityWeatherArray.first {
                return .success(cityWeather)
            }else{
                return .failure(.coreDataError(errorMessage: "fetch error - no city weather for \(String(cityId))"))
            }
        }catch{
            return .failure(.coreDataError(errorMessage: "fetch error \(error.localizedDescription)"))
        }
    }
    
    func fetchAllCities() -> CoreDataFullFetchCompletion {
        let request = CityWeather.createFetchRequest()
        
        do {
            let cityWeatherArray = try self.persistentContainer.viewContext.fetch(request)
            return .success(cityWeatherArray)
        }catch{
            return .failure(.coreDataError(errorMessage: "fetch error \(error.localizedDescription)"))
        }
    }
    
    //MARK: - forecast
    func save(cityForecaseForDateBase : CityForecastForDataBase, with completion : @escaping CoreDataCompletion) {
        persistentContainer.viewContext.perform {
            let cityId = cityForecaseForDateBase.cityId
            let coreDataFetch = self.fetchForecastFor(cityId: cityId)
            
            switch coreDataFetch {
            case .success(let cityInDataBase):
                //we have the city in the DB, so we need to update the DB with new values
                self.populate(cityForecast: cityInDataBase, with: cityForecaseForDateBase)
                
            case .failure(_):
                //we do not have any data in DB, so add it
                let cityForecast = CityForecast(context: self.persistentContainer.viewContext)
                self.populate(cityForecast: cityForecast, with: cityForecaseForDateBase)
            }
            
            do {
                try self.persistentContainer.viewContext.save()
                completion(nil)
            }catch{
                completion(.coreDataError(errorMessage: "saving error \(error.localizedDescription)"))
            }
        }
    }
    
    private func populate(cityForecast : CityForecast, with cityForecaseForDateBase :CityForecastForDataBase) {
        cityForecast.cityId = cityForecaseForDateBase.cityId
        cityForecast.cityName = cityForecaseForDateBase.cityName
        cityForecast.currentDate = cityForecaseForDateBase.currentDate
        cityForecast.currectDateTemp = cityForecaseForDateBase.currectDateTemp
        cityForecast.firstDateTemp = cityForecaseForDateBase.firstDateTemp
        cityForecast.secondDateTemp = cityForecaseForDateBase.secondDateTemp
        cityForecast.thirdDateTemp = cityForecaseForDateBase.thirdDateTemp
        cityForecast.fourthDateTemp = cityForecaseForDateBase.fourthDateTemp
        cityForecast.fifthDayeTemp = cityForecaseForDateBase.fifthDayeTemp
    }
    
    func checkIfUpdateRequired(for cityID : NSNumber) -> Bool {
        let result = fetchForecastFor(cityId: cityID)
        switch result {
        case .failure(_):
            return true //there is no such city, so we need to update
        case .success(let cityForecast):
            let currentStartOfDay = Date().startOfDay!
            if let dataBaseCurrentStartOfDay = cityForecast.currentDate?.startOfDay {
                if currentStartOfDay.isAfter(date: dataBaseCurrentStartOfDay, with: .day) {//if the current date is after the date saved in DB, get an update
                    return true
                }else{
                    return false //the current date is saved in the DB, so we don't need an update
                }
            }else{
                return true // if for some resone we don't have a current date in DB, get a new update
            }
        }
    }
    
    
    func fetchForecastFor(cityId : NSNumber) -> CoreDateForecastFetchCompletion {
        let request = CityForecast.createFetchRequest()
        let predicate = NSPredicate(format: "cityId = %@", cityId)
        request.predicate = predicate
        do {
            let forecastArray = try self.persistentContainer.viewContext.fetch(request)
            if let cityForecast = forecastArray.first {
                return .success(cityForecast)
            }else{
                return .failure(.coreDataError(errorMessage: "fetch error - no city forecast for \(String(cityId.intValue))"))
            }
        }catch{
            return .failure(.coreDataError(errorMessage: "fetch error \(error.localizedDescription)"))
        }
    }
    
}
