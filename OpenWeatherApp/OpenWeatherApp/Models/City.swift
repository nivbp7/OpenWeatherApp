//
//  City.swift
//  OpenWeatherApp
//
//  Created by niv ben-porath on 05/03/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import Foundation

class City {
    let name : String
    let id : Int
    
    var temp : String?
    var description : String?
    
    init(name: String, id: Int) {
        self.name = name
        self.id = id
        self.temp = nil
        self.description = nil
    }
    
    func set(temp :String?, andDescription description : String?) {
        self.temp = temp
        self.description = description
    }
    
    var showTemp : String {
        get {
            return (temp ?? "--") + Values.degreeSign
        }
    }
    
    var shownDescription : String {
        get {
            return description ?? ""
        }
    }
}
