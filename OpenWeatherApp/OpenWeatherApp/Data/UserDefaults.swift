//
//  UserDefaults.swift
//  OpenWeatherApp
//
//  Created by niv ben-porath on 04/03/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import Foundation

extension UserDefaults {
    public enum Keys {
        static let citiesShownInGrid = "citiesShownInGrid"
    }
    
    var citiesShownInGrid : Bool {
        set {
            set(newValue,forKey: Keys.citiesShownInGrid)
        }
        get{
            return bool(forKey: Keys.citiesShownInGrid)
        }
    }
}
