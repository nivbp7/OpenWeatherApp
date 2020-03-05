//
//  DataFetch.swift
//  OpenWeatherApp
//
//  Created by niv ben-porath on 05/03/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import Foundation

enum NetworkError :Error {
    case networkError(errorMessage : String)
}

typealias networkCompletion =  (Result<Bool,NetworkError>) -> Void

struct DataFetch {
    func fetchCurrentWetherForCityId(cityId : Int, with completion : @escaping networkCompletion ) {
        let moyaNetworkService = MoyaNetworkService()
        moyaNetworkService.getCurrentWeatherForCityId(cityId: cityId)
    }
}
