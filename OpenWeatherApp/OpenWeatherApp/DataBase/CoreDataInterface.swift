//
//  CoreDataInterface.swift
//  OpenWeatherApp
//
//  Created by niv ben-porath on 06/03/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import Foundation
import CoreData

typealias saveCompletion = (CoreDataError?) -> Void

enum CoreDataError : Error {
    case coreDataError(errorMessage : String)
}

struct CoreDataInterface {
    
    let persistentContainer: NSPersistentContainer
    
    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }
    
    func save(currectTemp : String, andCurrentTempDescription currentTempDescription : String, forCityId cityId : Int, with completion : @escaping saveCompletion) {
        
    }
}
