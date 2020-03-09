//
//  MoyaConfig.swift
//  OpenWeatherApp
//
//  Created by niv ben-porath on 05/03/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import Foundation
import Moya

//api.openweathermap.org/data/2.5/forecast?id=293397&appid=e4bb695a74b1eca68577848b1da1079d




enum OpenWetherApi {
    static private let apiKey = "e4bb695a74b1eca68577848b1da1079d"
    static private let baseUrlString = "https://api.openweathermap.org/data/2.5"
    
    static private let currentWeatherPath = "/weather"
    static private let forecastPath = "/forecast"
    
    case currentWeather(cityId : Int)
    case forecast(cityId : Int)
}

extension OpenWetherApi : TargetType {
    var baseURL: URL {
        return URL(string: OpenWetherApi.baseUrlString)!
    }
    
    var path: String {
        switch self {
        case.currentWeather(_):
            return OpenWetherApi.currentWeatherPath
        case .forecast:
            return OpenWetherApi.forecastPath
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
        
        var params : [String:Any] = [
            "appid":OpenWetherApi.apiKey,
            "units":"metric"
        ]
        
        switch self {
        case .currentWeather(let cityId):
            params["id"] = cityId
            
        case .forecast(let cityId):
            params["id"] = cityId
        }
        
        return .requestParameters(parameters: params, encoding: URLEncoding.default)
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    var validationType: ValidationType {
       return .successCodes
    }
    
    
    
}
