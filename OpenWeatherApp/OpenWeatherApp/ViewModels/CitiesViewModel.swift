//
//  CitiesViewModel.swift
//  OpenWeatherApp
//
//  Created by niv ben-porath on 04/03/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import Foundation
/*
 view model for the cities. it is initiated with static data, as per specification
 */

struct CitiesViewModel {
    
    private var cities : [City] = [
        City(name: Texts.jerusalem, id: Values.jerusalemId),
        City(name: Texts.telAviv, id: Values.telAvivId),
        City(name: Texts.haifa, id: Values.haifaId),
        City(name: Texts.eilat, id: Values.eilatId)
    ]
    
    func allCities() -> [City] {
        return cities
    }
}
