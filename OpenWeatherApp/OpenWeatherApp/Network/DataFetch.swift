//
//  DataFetch.swift
//  OpenWeatherApp
//
//  Created by niv ben-porath on 05/03/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import Foundation

enum FetchError :Error {
    case networkError(errorMessage : String)
    case parserError(errorMessage : String)
    case saveError(errorMessage : String)
}

typealias FetchCompletion =  (FetchError?) -> Void
typealias DataHandlerCompletion = () -> Void
typealias ForecastFetchCompletion = (FetchError?) -> Void

struct DataFetch {
    
    let coreDataInterface : CoreDataInterface?

    init(coreDataInterface : CoreDataInterface?) {
        self.coreDataInterface = coreDataInterface
    }
    
    //MARK: - Get weather data
    
    func fetchAllWeatherFrom(citiesViewModel : CitiesViewModel,with completion : @escaping DataHandlerCompletion) {
        
        let group = DispatchGroup()
        
        for city in citiesViewModel.allCities() {
            group.enter()
            fetchCurrentWetherForCityId(cityId: city.id) { (fetchError) in
                if let error = fetchError {
                    print(error.localizedDescription)
                }
                group.leave()
            }
        }
        
        group.notify(queue: DispatchQueue.global()) {
            completion()
        }
    }
    
    private func fetchCurrentWetherForCityId(cityId : Int, with completion : @escaping FetchCompletion ) {
        let moyaNetworkService = MoyaNetworkService()
        moyaNetworkService.getCurrentWeatherForCityId(cityId: cityId) { (result) in
            switch result {
            case .success(let data):
                let jsonParser = JsonParser(data: data)
                let parsedData : Result<CurrentWeather,Error> = jsonParser.decode()
                
                switch parsedData {
                case .success(let currentWeather):
                    self.saveCurrentWeather(currentWeather: currentWeather) { (coreDataError) in
                        if let error = coreDataError {
                            completion(.saveError(errorMessage: error.localizedDescription))
                        }else{
                            completion(nil)
                        }
                    }
                    
                case .failure(let parseError):
                    completion(.parserError(errorMessage: parseError.localizedDescription))
                }
                
            case .failure(let moyaError):
                completion(.networkError(errorMessage: moyaError.localizedDescription))
            }
        }
    }
    
    
    //MARK: - Get forecast data
    
    func fetchForecast(for cityId : Int, with completion : @escaping ForecastFetchCompletion) {
        let moyaNetworkService = MoyaNetworkService()
        moyaNetworkService.getForecastForCityId(cityId: cityId) { (result) in
            switch result {
            case .success(let data) :
                let jsonParser = JsonParser(data: data)
                let parsedData : Result<FullCityForecastForFiveDays,Error> = jsonParser.decode()
                
                switch parsedData {
                case .success(let fullCityForecastForFiveDays):
                    let cityForecastAggregator = CityForecastAggregator(fullCityForecastForFiveDays: fullCityForecastForFiveDays)
                    let cityForecastForDataBase = cityForecastAggregator.aggregate()
                    print("agg = \(cityForecastForDataBase)")
                    self.saveCityForecast(cityForecastForDataBase: cityForecastForDataBase) { (coreDataError) in
                        if let error = coreDataError {
                            completion(.saveError(errorMessage: error.localizedDescription))
                        }else{
                            completion(nil)
                        }
                    }
                    
                case .failure(let parseError):
                    completion(.parserError(errorMessage: parseError.localizedDescription))
                }
            case .failure(let moyaError):
                completion(.networkError(errorMessage: moyaError.localizedDescription))
            }
        }
    }
    
    
    
    
    private func saveCurrentWeather(currentWeather : CurrentWeather,with completion : @escaping CoreDataCompletion) {
        self.coreDataInterface?.save(currentWeather: currentWeather) { (coreDataError) in
            completion(coreDataError)
        }
    }
    
    private func saveCityForecast(cityForecastForDataBase : CityForecastForDataBase,with completion : @escaping CoreDataCompletion) {
        self.coreDataInterface?.save(cityForecaseForDateBase: cityForecastForDataBase, with: { (coreDataError) in
            completion(coreDataError)
        })
    }
    
    
    
    
}
