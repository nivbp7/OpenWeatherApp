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

enum CoreDataError : Error {
    case coreDataError(errorMessage : String)
}

struct CoreDataInterface {
    
    let persistentContainer: NSPersistentContainer
    
    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }
    
    
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
                return .failure(.coreDataError(errorMessage: "fetch error - no city weather"))
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
    
}
