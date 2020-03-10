//
//  Date+Utils.swift
//  OpenWeatherApp
//
//  Created by niv ben-porath on 09/03/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import Foundation


extension Date {
    var startOfDay : Date? {
        return Calendar.current.startOfDay(for: self)
    }
    
    var dayOfTheWeekInt : Int {
        return Calendar.current.component(.weekday, from: self)
    }
    
    func isAfter(date : Date) -> Bool {
        let result = Calendar.current.compare(self, to: date, toGranularity: .day)
        switch result {
        case .orderedSame,.orderedAscending:
            return false
        case .orderedDescending:
            return true
        }
    }
}
