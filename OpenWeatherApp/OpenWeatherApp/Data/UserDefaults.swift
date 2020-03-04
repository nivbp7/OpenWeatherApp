//
//  UserDefaults.swift
//  OpenWeatherApp
//
//  Created by niv ben-porath on 04/03/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import Foundation

//enum CitiesViewState : String {
//    case List
//    case Grid
//}

extension UserDefaults {
    public enum Keys {
//        static let citiesViewSavedState = "citiesViewSavedState"
        static let citiesShownInGrid = "citiesShownInGrid"
    }
    
//    var citiesViewSavedState : String {
//           set {
//               set(newValue,forKey: Keys.citiesViewSavedState)
//           }
//           get{
//            return string(forKey: Keys.citiesViewSavedState) ?? CitiesViewState.List.rawValue
//           }
//       }
    
    
    var citiesShownInGrid : Bool {
        set {
            set(newValue,forKey: Keys.citiesShownInGrid)
        }
        get{
            return bool(forKey: Keys.citiesShownInGrid)
        }
    }
}
