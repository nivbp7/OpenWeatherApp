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
                cityInDataBase.lastUpdate = NSNumber(value:currentWeather.dt)
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
                //we have the city in the DB, so now we check if we are at a new date
                let dateInDataBase = cityInDataBase.currentDate ?? Date().startOfDay!
                let dateFromServer = cityForecaseForDateBase.currentDate
                if dateFromServer.isAfter(date: dateInDataBase) {
                    //we got a new date from the server, so we need to update the DB with new values
                    let cityForecast = CityForecast(context: self.persistentContainer.viewContext)
                    cityForecast.cityId = cityForecaseForDateBase.cityId
                    cityForecast.cityName = cityForecaseForDateBase.cityName
                    cityForecast.currentDate = dateFromServer
                    cityForecast.currectDateTemp = cityForecaseForDateBase.currectDateTemp
                    cityForecast.firstDateTemp = cityForecaseForDateBase.firstDateTemp
                    cityForecast.secondDateTemp = cityForecaseForDateBase.secondDateTemp
                    cityForecast.thirdDateTemp = cityForecaseForDateBase.thirdDateTemp
                    cityForecast.fourthDateTemp = cityForecaseForDateBase.fourthDateTemp
                    cityForecast.fifthDayeTemp = cityForecaseForDateBase.fifthDayeTemp
                    print(cityForecast)
                }else{
                    #warning("fix")
                    //we are still on the same date, so show the previous data
                }
                
            case .failure(_):
                #warning("fix")
                //we do not have any data in DB, so add it
                print()
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
