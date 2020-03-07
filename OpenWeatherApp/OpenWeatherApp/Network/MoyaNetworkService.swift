//
//  MoyaNetworkService.swift
//  OpenWeatherApp
//
//  Created by niv ben-porath on 05/03/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import Foundation
import Moya

typealias MoyaCompletion = (Result<Data,Error>) -> Void

struct MoyaNetworkService {
    
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
}
