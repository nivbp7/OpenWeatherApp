//
//  MoyaConfig.swift
//  OpenWeatherApp
//
//  Created by niv ben-porath on 05/03/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import Foundation
import Moya

enum OpenWetherApi {
    static private let apiKey = "e4bb695a74b1eca68577848b1da1079d"
    static private let baseUrlString = "https://api.openweathermap.org/data/2.5"
    static private let currentWeatherPath = "/weather"
    
    case currentWeather(cityId : Int)
}

extension OpenWetherApi : TargetType {
    var baseURL: URL {
        return URL(string: OpenWetherApi.baseUrlString)!
    }
    
    var path: String {
        switch self {
        case.currentWeather(_):
            return OpenWetherApi.currentWeatherPath
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        // for unit testing!
        return Data()
    }
    
    var task: Task {
        // plain request, data request, parameters request, upload request and many more.
        switch self {
        case .currentWeather(let cityId):
            return .requestParameters(parameters:
                ["appid":OpenWetherApi.apiKey,
                 "id":cityId,
                 "units":"metric"
                    
                ],
                encoding:URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    var validationType: ValidationType {
       return .successCodes
    }
    
    
    
}
