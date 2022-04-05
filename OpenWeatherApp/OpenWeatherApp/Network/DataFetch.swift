//
//  DataFetch.swift
//  OpenWeatherApp
//
//  Created by niv ben-porath on 05/03/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import Foundation
/*
 This is the main object for fetching data from the network
 */

enum FetchError :Error {
    case networkError(errorMessage : String)
    case parserError(errorMessage : String)
    case saveError(errorMessage : String)
}

typealias FetchCompletion =  (FetchError?) -> Void
typealias DataHandlerCompletion = (Error?) -> Void
typealias ForecastFetchCompletion = (FetchError?) -> Void

@available(iOS 15.0, *)
struct DataFetch {
    
    let coreDataInterface : CoreDataInterface?
    
    init(coreDataInterface : CoreDataInterface?) {
        self.coreDataInterface = coreDataInterface
    }
    
    //MARK: - Get weather data
    
    //here we request all the cities weather data
    
//    func fetchAllWeatherFrom(citiesViewModel : CitiesViewModel,with completion : @escaping DataHandlerCompletion) {
//        //we setup a DispatchGroup and only once all the requests are handled, we continue.
//
//        let group = DispatchGroup()
//        var anyFetchError : FetchError?
//        for city in citiesViewModel.allCities() {
//            group.enter()
//            fetchCurrentWetherForCityId(cityId: city.id) { (fetchError) in
//                if let error = fetchError {
//                    anyFetchError = fetchError
//                    print(error.localizedDescription)
//                }
//                group.leave()
//            }
//        }
//
//        group.notify(queue: DispatchQueue.global()) {
//            if let err = anyFetchError {
//                //if we have an error, we send it back to the call site, and the call site will decide if to continue or not
//                completion(err)
//            }else{
//                completion(nil)
//            }
//        }
//    }
    
    func fetchAllWeatherFrom(citiesViewModel : CitiesViewModel,with completion : @escaping DataHandlerCompletion) {
        //we setup a DispatchGroup and only once all the requests are handled, we continue.
        
//        let group = DispatchGroup()
//        var anyFetchError : FetchError?
        Task {
            for city in citiesViewModel.allCities() {
                do {
                    print("start for \(city.name)")
                    async let didFetchCityWeather = fetchCurrentWetherForCityId(cityId: city.id)
                    let success = try await didFetchCityWeather
                    print("success")
                    if !success {
                        print("niv Failed")
                        completion(FetchError.networkError(errorMessage: ""))
                    }
                    else {
                        completion(nil)
                    }
                    
                }
                catch {
                    print("niv catch")
                    completion(error)
                }
                
            }
        }
        
//        for city in citiesViewModel.allCities() {
//            group.enter()
//            fetchCurrentWetherForCityId(cityId: city.id) { (fetchError) in
//                if let error = fetchError {
//                    anyFetchError = fetchError
//                    print(error.localizedDescription)
//                }
//                group.leave()
//            }
//        }
//
//        group.notify(queue: DispatchQueue.global()) {
//            if let err = anyFetchError {
//                //if we have an error, we send it back to the call site, and the call site will decide if to continue or not
//                completion(err)
//            }else{
//                completion(nil)
//            }
//        }
    }
    
    //fetching the weather for a specific city
    
    private func fetchCurrentWetherForCityId(cityId : Int) async throws -> Bool {
        let moyaNetworkService = MoyaNetworkService()//we use Moya for network fetching
        let data = try await moyaNetworkService.getCurrentWeatherForCityId(cityId: cityId)
        let jsonParser = JsonParser(data: data)
        let parsedData : Result<CurrentWeather,Error> = jsonParser.decode()
        print("\n")
        print(parsedData)
        print("\n")
        switch parsedData {
        case .failure(let error):
            throw error
        case .success(let currentWeather):
            if let saveResult = await self.saveCurrentWeather(currentWeather: currentWeather) {
                throw saveResult
            }
            else {
                return true
            }
        }
    }
    
    
//    private func fetchCurrentWetherForCityId(cityId : Int, with completion : @escaping FetchCompletion ) {
//        let moyaNetworkService = MoyaNetworkService()//we use Moya for network fetching
//
//
//        moyaNetworkService.getCurrentWeatherForCityId(cityId: cityId) { (result) in
//            switch result {
//            case .success(let data):
//                //if we get back data from the network, we parse it
//                let jsonParser = JsonParser(data: data)
//                let parsedData : Result<CurrentWeather,Error> = jsonParser.decode()
//
//                switch parsedData {
//                case .success(let currentWeather):
//                    //if we parsed the data correctly, we save it to DB
//                    self.saveCurrentWeather(currentWeather: currentWeather) { (coreDataError) in
//                        if let error = coreDataError {
//                            completion(.saveError(errorMessage: error.localizedDescription))
//                        }else{
//                            completion(nil)
//                        }
//                    }
//
//                case .failure(let parseError):
//                    completion(.parserError(errorMessage: parseError.localizedDescription))
//                }
//
//            case .failure(let moyaError):
//                completion(.networkError(errorMessage: moyaError.localizedDescription))
//            }
//        }
//    }
    
    
    //MARK: - Get forecast data
    
    //fetching specific city forecast
    func fetchForecast(for cityId : Int, with completion : @escaping ForecastFetchCompletion) {
        let moyaNetworkService = MoyaNetworkService()
        moyaNetworkService.getForecastForCityId(cityId: cityId) { (result) in
            switch result {
            case .success(let data) :
                let jsonParser = JsonParser(data: data)
                let parsedData : Result<FullCityForecastForFiveDays,Error> = jsonParser.decode()
                
                switch parsedData {
                case .success(let fullCityForecastForFiveDays):
                    //due to the fact that the way the server data is structured is different from how we want to display it in the app, we use an aggregator to change the structure
                    let cityForecastAggregator = CityForecastAggregator(fullCityForecastForFiveDays: fullCityForecastForFiveDays)
                    let cityForecastForDataBase = cityForecastAggregator.aggregate()
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
    
    private func saveCurrentWeather(currentWeather : CurrentWeather) async -> CoreDataError? {
        let result = await self.coreDataInterface?.save(currentWeather: currentWeather)
        print("niv \(result)")
        return result
//        self.coreDataInterface?.save(currentWeather: currentWeather) { (coreDataError) in
//            completion(coreDataError)
//        }
    }
    
    private func saveCityForecast(cityForecastForDataBase : CityForecastForDataBase,with completion : @escaping CoreDataCompletion) {
        self.coreDataInterface?.save(cityForecaseForDateBase: cityForecastForDataBase, with: { (coreDataError) in
            completion(coreDataError)
        })
    }
    
}
