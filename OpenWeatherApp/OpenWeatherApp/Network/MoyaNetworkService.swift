//
//  MoyaNetworkService.swift
//  OpenWeatherApp
//
//  Created by niv ben-porath on 05/03/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import Foundation
import Moya

/*
 this is the Moya network handling object
 */

typealias MoyaCompletion = (Result<Data,Error>) -> Void

struct MoyaNetworkService {
    //this is the call for getting weather data
    @available(*, renamed: "getCurrentWeatherForCityId(cityId:)")
    func getCurrentWeatherForCityId(cityId : Int, with completion : @escaping MoyaCompletion) {
        let moyaProvider = MoyaProvider<OpenWetherApi>()
        moyaProvider.request(.currentWeather(cityId: cityId)) { (result) in
            switch result {
            case .success(let responce):
                completion(.success(responce.data))
               
            case .failure(let moyaError):
                completion(.failure(moyaError))
            }
        }
    }
    
    func getCurrentWeatherForCityId(cityId : Int) async throws -> Data {
        return try await withCheckedThrowingContinuation { continuation in
            getCurrentWeatherForCityId(cityId: cityId) { result in
                continuation.resume(with: result)
            }
        }
    }
    
    
    func getForecastForCityId(cityId : Int, with completion : @escaping MoyaCompletion) {
        //this is the call for getting weather data

        let moyaProvider = MoyaProvider<OpenWetherApi>()
        moyaProvider.request(.forecast(cityId: cityId)) { (result) in
            switch result {
            case .success(let responce):
                completion(.success(responce.data))
                
            case .failure(let moyaError):
                completion(.failure(moyaError))
            }
        }
    }
    
}
