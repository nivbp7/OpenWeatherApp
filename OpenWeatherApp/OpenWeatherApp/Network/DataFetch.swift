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
}

typealias FetchCompletion =  (FetchError?) -> Void

struct DataFetch {
    
    func fetchAllWeatherFrom(citiesViewModel : CitiesViewModel) {
        
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
            print("done")
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
                    print(currentWeather)
                    completion(nil)
                    
                case .failure(let parseError):
                    completion(.parserError(errorMessage: parseError.localizedDescription))
                }
                
            case .failure(let moyaError):
                completion(.networkError(errorMessage: moyaError.localizedDescription))
                
            }
        }
    }
    
    
}
