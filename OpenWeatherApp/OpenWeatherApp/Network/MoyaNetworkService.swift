//
//  MoyaNetworkService.swift
//  OpenWeatherApp
//
//  Created by niv ben-porath on 05/03/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import Foundation
import Moya



struct MoyaNetworkService {
    
    func getCurrentWeatherForCityId(cityId : Int) {
        let moyaProvider = MoyaProvider<OpenWetherApi>()
        
        moyaProvider.request(.currentWeather(cityId: cityId)) { (result) in
            switch result {
            case .success(let responce):
                do {
                    print(try responce.mapJSON())
                }catch{
                    print("json error \(error.localizedDescription)")
                }
            case .failure(let moyaError):
                print("moya error \(moyaError.errorDescription)")
            }
            
        }
    }
    
}
